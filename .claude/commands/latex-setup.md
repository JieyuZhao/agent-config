Check whether `.vscode/settings.json` exists in the current project root.

- If it already exists, read it and report whether it contains `latex-workshop` keys. If yes, say "LaTeX settings already configured" and stop.
- If it does not exist, show the user what will be copied (the LaTeX Workshop config from `.agent-config/repo/assets/vscode/latex-settings.json`) and ask for confirmation before creating `.vscode/settings.json`.
- After confirmation, create `.vscode/` if needed and write the file.
- Also create `out/` in the project root if it does not exist, since the config sets `outDir: "./out"`.
