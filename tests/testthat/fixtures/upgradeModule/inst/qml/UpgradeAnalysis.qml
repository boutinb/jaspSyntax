import QtQuick
import JASP
import JASP.Controls

Form
{
	VariablesForm
	{
		AvailableVariablesList	{ name: "allVariablesList"						}
		AssignedVariablesList	{ name: "variables"; title: qsTr("Variables")	}
	}

	IntegerField { name: "count"; label: qsTr("Count"); defaultValue: 1 }
	IntegerField { name: "extra"; label: qsTr("Extra"); defaultValue: 0 }
}
