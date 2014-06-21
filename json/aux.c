#include <stdio.h>
#include "structure.h"

void print_tabs(int depth);
void print_value(int depth, Value* value);
void print_pair(int depth, Pair* pair);
void print_object(int depth, Member* firstMember);
void print_array(int depth, ArrayElement* firstElement);


void print_tabs(int depth) {
	int i;
	for (i = 0; i < depth; i++) {
		printf("  ");
	}
}


void print_value(int depth, Value* value) {
	switch (value->type) {
		case TYPE_OBJECT:
			print_object(depth, (Member*) value->value);
			break;
		case TYPE_ARRAY:
			print_array(depth, (ArrayElement*) value->value);
			break;
		default:
			printf("%s", (char*) value->value);
			break;
	}
}

void print_object(int depth, Member* firstMember) {
	Member* curMember = firstMember;
	if (curMember == NULL) {
		printf("{}");
		return;
	}
	printf("{\n");
	while (curMember != NULL) {
		print_tabs(depth+1);
		printf("%s: ", curMember->pair->name);
		print_value(depth+1, curMember->pair->value);
		if (curMember->nextMember)
			printf(",");
		printf("\n");
		curMember = curMember->nextMember;
	}
	print_tabs(depth);
	printf("}");
}

void print_array(int depth, ArrayElement* firstElement) {
	ArrayElement* curElement = firstElement;
	if (curElement == NULL) {
		printf("[]");
		return;
	}
	printf("[\n");
	while (curElement != NULL) {
		print_tabs(depth+1);
		print_value(depth+1, curElement->value);
		if (curElement->nextArrayElement)
			printf(",");
		printf("\n");
		curElement = curElement->nextArrayElement;
	}
	print_tabs(depth);
	printf("]");
}
