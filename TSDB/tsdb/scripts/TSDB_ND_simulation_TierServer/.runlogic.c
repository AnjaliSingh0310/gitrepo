
#include "../../include/runlogic.h"


LogicBlockElement elementsCtrBlock_1 [] = {
	{0, 0, 0},
};

LogicBlockCtrl ctrlBlock[] = {
	{ "Block1", NS_CTRLBLOCK_SEQUENCE, 1, elementsCtrBlock_1, 0, ""},
};

int numCtrlBlocks = 1;

int switchBlockDefaultValue = -1;
