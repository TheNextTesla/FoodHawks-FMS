import QtQuick 2.0

Item {
    id: root
        property int currentIndex: 0
        default property Item newContent

        onNewContentChanged: {
            newContent.parent = root
            newContent.visible = Qt.binding(bindingsClosure(root.children.length - 1))
        }

        function bindingsClosure(index) { return function() { return root.currentIndex === index } }
}
