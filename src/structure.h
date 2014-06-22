#ifndef __STRUCTURE_H__
#define __STRUCTURE_H__

typedef enum {
	TYPE_STRING = 0,
	TYPE_NUMBER,
	TYPE_BOOLEAN,
	TYPE_NULL,
	TYPE_ARRAY,
	TYPE_OBJECT
} ValueType;

typedef struct Value {
        ValueType type;
        void* value;
} Value;

typedef struct Pair {
	char* name;
	Value* value;
} Pair;

typedef struct Member {
	Pair* pair;
        struct Member* nextMember;
} Member;

typedef struct ArrayElement {
        Value* value;
        struct ArrayElement* nextArrayElement;
} ArrayElement;

Value* newValue(ValueType type, void* value);
Pair* newPair(char* name, Value* value);
Member* newMember(Pair* pair, Member* nextMember);
ArrayElement* newArrayElement(Value * value, ArrayElement* nextArrayElement);

#endif
