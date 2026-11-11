import QtQuick
import JASP.Module

Upgrades
{
	// 0.1 had "number" and "vars", 0.2 calls them "count" and "variables"
	Upgrade
	{
		functionName:	"UpgradeAnalysis"
		fromVersion:	"0.1"
		toVersion:		"0.2"
		msg:			"The options were upgraded"

		ChangeRename	{ from: "number";	to: "count"									}
		ChangeRename	{ from: "vars";		to: "variables"								}
		ChangeSetValue	{ name: "extra";	jsonValue: 3;	msg: "extra is new in 0.2"	}
	}
}
