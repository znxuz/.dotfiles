const {
	aceVimMap,
	mapkey,
	imap,
	imapkey,
	getClickableElements,
	vmapkey,
	map,
	unmap,
	cmap,
	addSearchAlias,
	removeSearchAlias,
	tabOpenLink,
	readText,
	Clipboard,
	Front,
	Hints,
	Visual,
	RUNTIME
} = api;

map("<Ctrl-[>", "<Esc>");
imap("<Ctrl-[>", "<Esc>");
Hints.characters = 'asdfgqwertzxcvbyuiophjklnm';
Hints.style('font-family: Noto Sans; font-size: 12px; border: solid 2px #ea6962; color: #fbf1c7; background: none; background-color: #1d2021;');
Hints.style("font-family: Noto Sans; font-size: 12px; border: solid 2px #ea6962; color: #fbf1c7; background: none; background-color: #1d2021;", "text");
settings.focusFirstCandidate = true;
settings.hintAlign = "left";

unmap("R"); // unmap tab right
unmap("E"); // unmap tab left
unmap("x"); // unmap close tab
unmap("<Ctrl-h>") // history
unmap("<Ctrl-j>") // download

// tab history
map("<Alt-o>", "B");
map("<Alt-i>", "F");

// page history
map("<Alt-j>", "S");
map("<Alt-k>", "D");

map("F", "C"); // open link in background
map("<Alt-f>", "cf"); // open links in background
map("C", "X"); // reopen closed tab
map("yf", "ya"); // copy link to clip
map("<Alt-6>", "<Ctrl-6>"); // prev tab
map("^", "g0"); // go to first tab
map("$", "g$"); // go to first tab

unmap("gx");
mapkey("gx", "open shortcuts", function() {
	tabOpenLink("chrome://extensions/shortcuts");
});

settings.theme = `
:root {
  --font: 'Hermit', sans;
  --font-size: 11;
  --fg: #fbf1c7;
  --bg: #1d2021;
  --bg-dark: #1d2021;
  --border: #2D2E2E;
  --main-fg: #fbf1c7;
  --info-fg: #A6E22E;
  --select: #a89984;
}
.sk_theme {
	background: var(--bg);
	color: var(--fg);
}
.sk_theme tbody {
	color: #b8bb26;
}
.sk_theme input {
	color: #d9dce0;
}
.sk_theme .url {
	color: #98971a;
}
.sk_theme .annotation {
	color: #b16286;
}
.sk_theme .omnibar_highlight {
	color: #333;
	background: var(--fg);
}
.sk_theme #sk_omnibarSearchResult ul>li:nth-child(odd) {
	background: var(--bg);
}
.sk_theme #sk_omnibarSearchResult ul>li.focused {
	background: #d3869b;
}

/*  ACE Editor  */
#sk_editor {
  background: var(--bg) !important;
  height: 50% !important;
}
.ace_dialog-bottom {
  border-top: 1px solid var(--bg) !important;
}
.ace-chrome .ace_print-margin,
.ace_gutter,
.ace_gutter-cell,
.ace_dialog {
  background: var(--bg) !important;
}
.ace-chrome {
  color: var(--fg) !important;
}
.ace_gutter,
.ace_dialog {
  color: var(--fg) !important;
}
.ace_cursor {
  color: var(--fg) !important;
}
.normal-mode .ace_cursor {
  background-color: var(--select) !important;
  border: var(--select) !important;
  opacity: 1 !important;
}
.ace_marker-layer .ace_selection {
  background: var(--select) !important;
}
.ace_editor,
.ace_dialog span,
.ace_dialog input {
  font-family: var(--font);
  font-size: var(--font-size);
}
`;
