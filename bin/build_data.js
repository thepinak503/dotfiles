#!/usr/bin/env node
const fs = require('fs');
const path = require('path');

const DOTFILES_DIR = path.dirname(__dirname);
const BASH_ALIASES = path.join(DOTFILES_DIR, 'shells', 'bash', 'aliases.bash');
const BASH_FUNCS = path.join(DOTFILES_DIR, 'shells', 'bash', 'functions.bash');
const OUTPUT_FILE = path.join(DOTFILES_DIR, 'docs', 'data.js');

function get_aliases() {
    if (!fs.existsSync(BASH_ALIASES)) return [];
    const content = fs.readFileSync(BASH_ALIASES, 'utf8');
    const lines = content.split('\n');
    const data = [];
    let current_category = "General";

    for (const line of lines) {
        const trimmed = line.trim();
        if (trimmed.startsWith("# ---")) {
            current_category = trimmed.replace(/#\s*-+/g, '').replace(/-+/g, '').trim();
        } else if (trimmed.startsWith("alias ")) {
            const match = trimmed.match(/alias ([^=]+)=['"](.+)['"]/);
            if (match) {
                const [, name, cmd] = match;
                data.push({ category: current_category, name, cmd });
            }
        }
    }
    return data;
}

function get_functions() {
    if (!fs.existsSync(BASH_FUNCS)) return [];
    const content = fs.readFileSync(BASH_FUNCS, 'utf8');
    const lines = content.split('\n');
    const data = [];
    let current_category = "General";

    let last_found_desc = "No description available.";

    for (let i = 0; i < lines.length; i++) {
        const line = lines[i].trim();
        if (line.startsWith("# ===========================")) {
            if (i + 1 < lines.length) {
                const cat = lines[i+1].replace(/#/g, '').trim();
                if (cat && cat.length < 50) current_category = cat;
            }
            last_found_desc = "No description available.";
        } else if (line.match(/^[A-Za-z0-9_.-]+\s*\(\)\s*\{/)) {
            const name = line.split('(')[0].trim();
            let desc_lines = [];
            
            let j = i - 1;
            while (j >= 0) {
                const prev = lines[j].trim();
                if (prev.startsWith("#")) {
                    const content = prev.replace(/^#\s*/, '').trim();
                    if (content && !content.includes("===")) {
                        desc_lines.unshift(content);
                    }
                    j--;
                } else if (!prev) {
                    if (desc_lines.length > 0) break;
                    j--;
                    if (j >= 0 && !lines[j].trim()) break;
                } else {
                    // It's another function or code. 
                    // If we haven't found a comment block for this specific function,
                    // we might want to check if the function above has a comment.
                    break;
                }
                if (i - j > 6) break;
            }

            const desc = desc_lines.length > 0 ? desc_lines.join(' ') : last_found_desc;
            if (desc_lines.length > 0) last_found_desc = desc;

            data.push({ category: current_category, name, desc });
        } else if (line && !line.startsWith("#")) {
            // If we hit any non-comment non-empty line that isn't a function, reset the "inherit" flag
            // unless it's an alias which often sits between functions.
            if (!line.startsWith("alias ")) {
                last_found_desc = "No description available.";
            }
        }
    }
    return data;
}

console.log("🛠️ Building search index...");
const aliases = get_aliases();
const functions = get_functions();

const result = {
    aliases,
    functions,
    generatedAt: new Date().toISOString()
};

const output = "const dotfilesData = " + JSON.stringify(result, null, 2) + ";";
fs.writeFileSync(OUTPUT_FILE, output);

console.log("✅ Indexed " + aliases.length + " aliases and " + functions.length + " functions into docs/data.js");
