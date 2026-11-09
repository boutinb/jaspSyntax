import QtQuick
import JASP
import JASP.Controls

Form
{
	IntegerField
	{
		name:			"lag"
		label:			qsTr("Lag")
		defaultValue:	2
		min:			1
		max:			dataSetInfo.rowCount
	}
}
