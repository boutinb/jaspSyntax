import QtQuick
import JASP.Module

Description
{
	title: qsTr("Syntax Upgrade Module")
	description: qsTr("Module fixture with an Upgrades.qml for jaspSyntax API tests.")
	preloadData: true
	hasWrappers: true

	Analysis
	{
		title: qsTr("Upgrade Analysis")
		func: "UpgradeAnalysis"
		qml: "UpgradeAnalysis.qml"
	}
}
