#include <stdlib.h>
#include "structure.h"

Value* newValue(ValueType type, void* value) {
	Value* newValue = (Value*) malloc(sizeof(Value));
	newValue->type = type;
	newValue->value = value;
	return newValue;
}

Pair* newPair(char* name, Value* value) {
	Pair* newPair = (Pair*) malloc(sizeof(Pair));
	newPair->name = name;
	newPair->value = value;
	return newPair;
}

Member* newMember(Pair* pair, Member* nextMember) {
	Member* newMember = (Member*) malloc(sizeof(Member));
	newMember->pair = pair;
	newMember->nextMember = nextMember;
	return newMember;
}

ArrayElement* newArrayElement(Value * value, ArrayElement* nextArrayElement) {
	ArrayElement* newArrayElement = (ArrayElement*) malloc(sizeof(ArrayElement));
	newArrayElement->value = value;
	newArrayElement->nextArrayElement = nextArrayElement;
	return newArrayElement;
}

