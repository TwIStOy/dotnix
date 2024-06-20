[
  {
    "key" = "ctrl+l";
    "command" = "-extension.vim_navigateCtrlL";
    "when" = "editorTextFocus && vim.active && vim.use<C-l> && !inDebugRepl";
  }
  {
    "key" = "ctrl+l";
    "command" = "-workbench.action.chat.clear";
    "when" = "hasChatProvider && inChat";
  }
  {
    "key" = "ctrl+l";
    "command" = "-notebook.centerActiveCell";
    "when" = "notebookEditorFocused";
  }
  {
    "key" = "ctrl+l";
    "command" = "editor.action.inlineSuggest.commit";
    "when" = "inlineSuggestionHasIndentationLessThanTabSize && inlineSuggestionVisible && !editorHoverFocused && !editorTabMovesFocus";
  }
  {
    "key" = "tab";
    "command" = "-editor.action.inlineSuggest.commit";
    "when" = "inlineSuggestionHasIndentationLessThanTabSize && inlineSuggestionVisible && !editorHoverFocused && !editorTabMovesFocus && !suggestWidgetVisible";
  }
]
