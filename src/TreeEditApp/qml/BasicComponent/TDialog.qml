import QtQuick 2.12
import QtQuick.Dialogs 1.3
Item {
    //顶层使用Item，不用FileDialog，屏蔽FileDialog内部属性和函数
    enum Type {
        CreateFile,
        OpenFile,
        OpenFiles,
        OpenFolder
    }
    property int __type
    property var __acceptCallback: function(file) {}

    FileDialog {
        id: d
        onAccepted: {
            switch(__type) {
            case TDialog.Type.CreateFile:
                __acceptCallback(d.fileUrl)
                break
            case TDialog.Type.OpenFile:
                __acceptCallback(d.fileUrl)
                break
            case TDialog.Type.OpenFiles:
                __acceptCallback(d.fileUrls)
                break
            case TDialog.Type.OpenFolder:
                __acceptCallback(d.folder)
                break
            }
        }
    }
    function createFile(title, nameFilters, callback) {
        __type = TDialog.Type.CreateFile
        d.selectExisting = false
        d.selectFolder = false
        d.selectMultiple = false
        d.title = title
        d.nameFilters = nameFilters
        __acceptCallback = callback
        d.open()
    }
    function openFile(title, nameFilters, callback) {
        __type = TDialog.Type.OpenFile
        d.selectExisting = true
        d.selectFolder = false
        d.selectMultiple = false
        d.title = title
        d.nameFilters = nameFilters
        __acceptCallback = callback
        d.open()
    }
    function openFiles(title, nameFilters, callback) {
        __type = TDialog.Type.OpenFiles
        d.selectExisting = true
        d.selectFolder = false
        d.selectMultiple = true
        d.title = title
        d.nameFilters = nameFilters
        __acceptCallback = callback
        d.open()
    }
    function openFolder(title, callback) {
        __type = TDialog.Type.OpenFolder
        d.selectExisting = true
        d.selectFolder = true
        d.selectMultiple = false
        d.title = title
        __acceptCallback = callback
        d.open()
    }
}
