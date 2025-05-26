import QtQuick
import QtQuick.Controls

Window {
    width: 800
    height: 600

    visible: true
    title: qsTr("Business Card")

    component ContactInfo: QtObject {
        // Always on display info
        property string name
        property url photo
        property string occupation
        property string phone
        property string email
    }

    ContactInfo {
        id: myContactInfo

        name: "Tamas Szonyi"
        photo: Qt.resolvedUrl("Tamas_Szonyi.jpg")
        occupation: "Engineer"
        phone: "+49 1520 6244007"
        email: "szonyitb@gmail.com"
    }

    Rectangle {
        id: background
        width: Window.width
        height: Window.height
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 1.0; color: "steelblue" }
            GradientStop { position: 0.0; color: "lightsteelblue" }
        }

        Image {
            id: img
            source: myContactInfo.photo
            width: 150
            height: 150
            anchors.right: background.right
            anchors.rightMargin: 20
            anchors.top: background.top
            anchors.topMargin: 20
            anchors.bottomMargin: 20
            anchors.bottom: detailsComponent.top
        }

        Column {
            id: basicInfoContainer
            anchors.left: background.left
            anchors.top: background.top
            anchors.leftMargin: 15
            anchors.topMargin: 20
            anchors.bottomMargin: 20
            spacing: 10

            Text {
                id: basicInfoName
                text: qsTr(myContactInfo.name)
                font.pointSize: 40
                font.weight: Font.Bold
            }

            Text {
                id: basicInfoCompanyOccupation
                anchors.topMargin: 50
                anchors.leftMargin: 5
                text: qsTr(myContactInfo.occupation)
                anchors.bottomMargin: 10
                font.pointSize: 20
            }

            Text {
                id: basicInfoPhone
                anchors.topMargin: 25
                anchors.leftMargin: 5
                text: qsTr(myContactInfo.phone)
                anchors.bottomMargin: 10
                font.pointSize: 16
            }

            Text {
                id: basicInfoEmail
                anchors.topMargin: 20
                anchors.leftMargin: 5
                text: qsTr(myContactInfo.email)
                anchors.bottomMargin: 10
                font.pointSize: 16
            }

        }

        Rectangle {
            id: detailsBtn

            property bool checked: false
            property bool checkable: true

            signal clicked

            anchors {
                left: parent.left
                bottom: parent.bottom
                leftMargin: 20
                bottomMargin: 20
            }
            width: 120
            height: 40
            radius: height / 2

            color: detailsBtn.checked || btnHandler.pressed ? "white" : "black"
            border.color: detailsBtn.checked || btnHandler.pressed ? "black" : "white"

            Text {
                id: btnText
                anchors.centerIn: parent
                text: qsTr("Details")
                font.weight: Font.Bold
                color: detailsBtn.checked || btnHandler.pressed ? "black" : "white"
            }

            TapHandler {
                id: btnHandler

                onTapped: {
                    if(detailsBtn.checkable){
                        detailsBtn.checked = !detailsBtn.checked
                    }

                    detailsBtn.clicked()
                }
            }
        }

        Connections {
            target: detailsBtn
            function onClicked() {
                detailsLoader.active = detailsBtn.checked;
            }
        }

        Loader {
            id: detailsLoader
            active: false
            anchors.top: img.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 40
            height: parent.height - img.height - detailsBtn.height - 60
            sourceComponent: detailsComponent


            Component {
                id: detailsComponent

                Column {
                    spacing: 20

                    // Title placed above the ScrollView
                    Text {
                        id: detailsTitle
                        text: qsTr("Experiences")
                        font.weight: Font.Bold
                        font.pointSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    ScrollView {
                        id: scrollView
                        width: parent.width - 40
                        height: parent.height - 100
                        clip: true

                        Row {
                            id: columnContainer
                            spacing: 160
                            width: implicitWidth
                            height: implicitHeight

                            property var columnData: [
                                {
                                    title: "Dk-Logic",
                                    experience: [" developed SCADA/HMI interfaces"]
                                },
                                {
                                    title: "BlueWorkforce",
                                    experience: ["Developed UI components using QML (Qt)",
                                        "Tested robotic system", "Wrote user guides."]
                                },
                                {
                                    title: "Targomo",
                                    experience: ["Assisted UX in data collection.",
                                        "Created user documentation",
                                        "Facilitated SCRUM process",
                                        "Led testing of apps.",
                                        "Developed E2E tests."]
                                },
                                {
                                    title: "DeepL",
                                    experience: ["Maintained automated test infrastructure.",
                                        "Performed weekly releases.",
                                        "Coordinated cross-team testing efforts."]
                                },
                            ]

                            Repeater {
                                model: columnContainer.columnData
                                delegate: Column {
                                    spacing: 20
                                    width: 150

                                    Text {
                                        text: modelData.title
                                        font.bold: true
                                        font.pointSize: 16
                                        horizontalAlignment: Text.AlignHCenter
                                    }

                                    Repeater {
                                        model: modelData.experience
                                        delegate: Row {
                                            spacing: 5

                                            Text {
                                                text: "•"
                                                font.pointSize: 14
                                            }

                                            Text {
                                                text: modelData
                                                font.pointSize: 14
                                            }
                                        }
                                    }
                                }
                            }

                            Rectangle {
                                width: 20
                                height: 1
                                color: "transparent"
                            }
                        }
                    }
                }
            }
        }
    }
}
