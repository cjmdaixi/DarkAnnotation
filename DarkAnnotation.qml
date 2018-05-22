import QtQuick 2.7
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3

Item {
    id: control
    width: 330
    height: 134
    property real radius:5
    Canvas{
        id: warnCanvas
        anchors.fill: parent
        visible: false
        property real margins: 5
        property real arrowHeight: 25
        onPaint: {
            var ctx = getContext("2d");
            var px = margins;
            var py = margins;
            py = height / 2;
            ctx.beginPath();
            // 移动到尖角顶点
            ctx.moveTo(px, py);
            // 尖角底座的上顶点
            px += arrowHeight;
            py -= arrowHeight;
            ctx.lineTo(px, py);
            // 主体的左上角(圆弧)
            ctx.arc(px + control.radius, margins + control.radius,
                    control.radius, Math.PI, Math.PI * 3 / 2, false);
            // 主体的右上角(圆弧)
            ctx.arc(width - margins - control.radius, margins + control.radius,
                    control.radius, -Math.PI / 2, 0, false);
            // 主体的右下角(圆弧)
            ctx.arc(width - margins - control.radius, height - margins - control.radius,
                    control.radius, 0, Math.PI / 2, false);
            // 主体的左下角(圆弧)
            ctx.arc(px + control.radius, height - margins - control.radius,
                    control.radius,  Math.PI / 2, Math.PI, false);
            // 尖角底座的下顶点
            py = height / 2 + arrowHeight;
            ctx.lineTo(px, py);
            // 回到尖角顶点
            px = margins;
            py = height / 2;
            ctx.lineTo(px, py);
            ctx.closePath();
            ctx.lineWidth = 4;
            ctx.lineCap = "butt";
            ctx.strokeStyle = "#b200b2";
            ctx.lineJoin = "miter";
            ctx.stroke();
            ctx.fillStyle = "#362e23";
            ctx.fill();
        }
    }
    Glow {
        id: warnCanvasEffect
        anchors.fill: warnCanvas
        radius: 10
        spread: 0.2
        color: "#aab200b2"
        source: warnCanvas
        smooth: true
        cached: true
    }

    Canvas{
        id: downArrow
        width: 50
        height: 50
        property real margins: 5
        property real arrowLength: 16
        anchors{centerIn: warnCanvas; horizontalCenterOffset: -80}
        visible: warnCanvasEffect.visible
        onPaint: {
            var ctx = getContext("2d");
            var px = margins;
            var py = margins;
            px = width / 2 - margins - arrowLength
            py = margins + 5;
            ctx.moveTo(px, py);
            px += arrowLength;
            py += arrowLength;
            ctx.lineTo(px, py);
            px += arrowLength;
            py -= arrowLength;
            ctx.lineTo(px, py);
            px -= arrowLength;
            py = margins + 5 + arrowLength - arrowLength / Math.sin(Math.PI / 4);
            ctx.moveTo(px, py);
            py += arrowLength / Math.sin(Math.PI / 4);
            ctx.lineTo(px, py);
            px = width / 2 - arrowLength - margins;
            py += 12;
            ctx.moveTo(px, py);
            px += arrowLength * 2;
            ctx.lineTo(px, py);
            ctx.lineWidth = 6;
            ctx.lineCap = "butt";
            ctx.strokeStyle = "#b200b2";
            ctx.lineJoin = "miter";
            ctx.stroke();
        }

    }
    Item{
        id: warnTextItem
        height: 80
        width: 200
        anchors{verticalCenter: warnCanvas.verticalCenter; right: warnCanvas.right}
        Text{
            id: warnTextLarge
            text: "Too Far"
            font{family: "Arial"; bold: true; pointSize: 30}
            anchors{top: parent.top; left: parent.left}
            color:  "#b200b2"
        }
        Text{
            id: warnTextSmall
            text: "pull down"
            font{family: "Arial"; pointSize: 25}
            anchors{bottom: parent.bottom; left: parent.left; leftMargin: 5}
            color:  "#b200b2"
        }
    }
}
