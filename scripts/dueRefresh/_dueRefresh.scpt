JsOsaDAS1.001.00bplist00�Vscript_2// Script to add tags to "@dueTomorrow", "@dueToday" and "@pastDue" items when due tag/date match "@due(yyyy-mm-dd)" format. Works well when chained to this script that convert informal date to "yyyy-mm-dd" date format (with Keyboard Maestro) : https://forum.keyboardmaestro.com/t/convert-informal-date-times-to-yyyy-mm-dd-hh-mm-in-taskpaper-3-preview/2941
// This theme support the "@dueTomorrow", "@dueToday" and "@pastDue" tags styling with yellow,green and red colors : http://support.hogbaysoftware.com/t/theme-tomorrow-night-eighties-inspired-theme-dark-light-with-omnifocus-like-searches-tags/2954
// This Keyboard Maestro script run the script when a new .taskpaper file is opened : 

function TaskPaperContextScript(editor, options) {
    var today = DateTime.format('today');
    var outline = editor.outline;
    
    outline.groupUndoAndChanges(function () {

      outline.evaluateItemPath('//@dueToday')
      .forEach(function (each) {
        each.removeAttribute('data-dueToday');
      });

      outline.evaluateItemPath('//@dueTomorrow')
      .forEach(function (each) {
        each.removeAttribute('data-dueTomorrow');
      });

      outline.evaluateItemPath('//@pastDue')
      .forEach(function (each) {
        each.removeAttribute('data-pastDue');
      });

      outline.evaluateItemPath('//@due = [d] today')
      .forEach(function (each) {
        each.setAttribute('data-dueToday', '');
      });

      outline.evaluateItemPath('//@due = [d] tomorrow')
      .forEach(function (each) {
        each.setAttribute('data-dueTomorrow', '');
      });

      outline.evaluateItemPath('//@due < [d] today')
      .forEach(function (each) {
        each.setAttribute('data-pastDue', '');
      });

    });
     
}

Application("TaskPaper")
.documents[0].evaluate({
    script: TaskPaperContextScript.toString()
})                              Hjscr  ��ޭ