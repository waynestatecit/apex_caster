// This file is part of WSU_Caster, an Apex-to-database type casting utility for the Force.com platform.
//
// Copyright 2013-2014, Wayne State University
// License: 3-clause BSD license.  See LICENSE.

public class WSU_Caster {
    private static Map<String, Map<String, List<Object>>> edMap = new Map<String, Map<String, List<Object>>>();
    private static WSU_Util u = new WSU_Util();

    static {
    }

    public static Integer getTypeEnum(sObject sobj, String field) {
        return getTypeEnum(sobj.getSObjectType(), field);
    }

    public static Integer getTypeEnum(Schema.SObjectType sobjType, String field) {
        Integer typeEnum = getTypeEnum(String.valueOf(sobjType), field);
        if (typeEnum == null) {
            Map<String, Schema.SObjectField> fieldTokens = sobjType.getDescribe().fields.getMap();
            Map<String, List<Object>> newEDs = new Map<String, List<Object>>();
            for (String fieldName : fieldTokens.keySet()) {
                Schema.SObjectField fieldToken = fieldTokens.get(fieldName);
                Schema.DescribeFieldResult describe = fieldToken.getDescribe();

                if (describe.getType() != Schema.DisplayType.String &&
                    describe.getType() != Schema.DisplayType.Phone &&
                    describe.getType() != Schema.DisplayType.Email &&
                    describe.getType() != Schema.DisplayType.TextArea) {
                    newEDs.put(fieldName.toLowerCase(), new List<Object>{describe.getType().ordinal()});
                }
            }
            edMap.put(String.valueOf(sobjType).toLowerCase(), newEDs);
            return getTypeEnum(sobjType, field);
        } else {
            return typeEnum;
        }
    }

    public static Integer getTypeEnum(String sobjName, String field) {
        if (edMap.containsKey(sobjName.toLowerCase())) {
            Map<String, List<Object>> edFieldMap = edMap.get(sobjName.toLowerCase());
            if (edFieldMap.containsKey(field.toLowerCase())) {
                return (Integer)((List<Object>)edFieldMap.get(field.toLowerCase())).get(0);
            } else {
                // Treat as String
                return -1;
            }
        } else {
            return null;
        }
    }

    public static void sPut(sObject sobj, String field, Object value) {
        sPut(sobj, field, value, true);
    }

    public static void sPut(sObject sobj, String field, Object value, Boolean allowCasting) {
        Integer typeEnum = getTypeEnum(sobj, field);

        if (typeEnum == -1) { // Treat as a String
            try {
                sobj.put(field, stringHandler(value, allowCasting));
            } catch (CasterException e) {
                e.setMessage(e.getMessage()
                    .replace(
                        '{sobjectName}', String.valueOf(sobj.getSObjectType())
                    )
                    .replace(
                        '{fieldName}', field
                    )
                );
                throw e;
            }
        } else {
            try { // I know this has a pretty big scope, but I'm avoiding redundancy
                if (typeEnum == DisplayType.Boolean.ordinal()) {
                    sobj.put(field, booleanHandler(value, allowCasting));
                } else if (typeEnum == DisplayType.Integer.ordinal()) {
                    sobj.put(field, integerHandler(value, allowCasting));
                } else if (typeEnum == DisplayType.Double.ordinal()) {
                    sobj.put(field, doubleHandler(value, allowCasting));
                } else if (typeEnum == DisplayType.Date.ordinal()) {
                    sobj.put(field, dateHandler(value, allowCasting));
                } else if (typeEnum == DisplayType.Time.ordinal()) {
                    sobj.put(field, timeHandler(value, allowCasting));
                } else if (typeEnum == DisplayType.ID.ordinal() ||
                           typeEnum == DisplayType.Reference.ordinal()) {
                    sobj.put(field, idHandler(value, allowCasting));
                } else {
                }
            } catch (CasterException e) {
                e.setMessage(e.getMessage()
                    .replace(
                        '{sobjectName}', String.valueOf(sobj.getSObjectType())
                    )
                    .replace(
                        '{fieldName}', field
                    )
                );
                throw e;
            }
        }
    }

    private static Boolean booleanHandler(Object value, Boolean allowCasting) {
        if (value instanceof Boolean) {
            return (Boolean)value;
        } else {
            if (allowCasting) {
                if (value instanceof String) {
                    String valueString = (String)value;
                    if (valueString == 'false' || valueString == 'False' || valueString == 'F' ||
                        valueString == 'f' || valueString == 'no' || valueString == 'No' || valueString == '') {
                        return false;
                    } else {
                        return true;
                    }
                } else if (value instanceof Integer) {
                    Integer valueInteger = (Integer)value;
                    if (valueInteger == 0) {
                        return false;
                    } else {
                        return true;
                    }
                } else if (value instanceof Double) {
                    Double valueDouble = (Double)value;
                    if (valueDouble == 0.0) {
                        return false;
                    } else {
                        return true;
                    }
                } else if (value instanceof List<Object>) {
                    List<Object> valueList = (List<Object>)value;
                    if (valueList.size() == 0) {
                        return false;
                    } else {
                        return true;
                    }
                } else if (value instanceof Map<String, Object>) {
                    Map<String, Object> valueMap = (Map<String, Object>)value;
                    if (valueMap.size() == 0) {
                        return false;
                    } else {
                        return true;
                    }
                } else {
                    throw new CasterException('Unsupported type for casting to Boolean for value ' + value + ' on {sobjectName}.{fieldName}');
                }
            } else {
                throw new CasterException('Casting disallowed for non-Boolean value ' + value + ' on {sobjectName}.{fieldName}');
            }
        }
    }

    private static Integer integerHandler(Object value, Boolean allowCasting) {
        if (value instanceof Integer) {
            return (Integer)value;
        } else {
            if (allowCasting) {
                if (value instanceof Boolean) {
                    if ((Boolean)value) {
                        return 1;
                    } else {
                        return 0;
                    }
                } else if (value instanceof String) {
                    Integer valueInteger = null;
                    try {
                        valueInteger = Integer.valueOf((String)value);
                    } catch (System.TypeException e) {
                        valueInteger = Double.valueOf((String)value).intValue();
                    }
                    return valueInteger;
                } else if (value instanceof Double) {
                    return ((Double)value).intValue();
                } else if (value instanceof List<Object>) {
                    return ((List<Object>)value).size();
                } else if (value instanceof Map<String, Object>) {
                    return ((Map<String, Object>)value).size();
                } else {
                    throw new CasterException('Unsupported type for casting to Integer for value ' + value + ' on {sobjectName}.{fieldName}');
                }
            } else {
                throw new CasterException('Casting disallowed for non-Integer value ' + value + ' on {sobjectName}.{fieldName}');
            }
        }
    }

    private static Double doubleHandler(Object value, Boolean allowCasting) {
        if (value instanceof Double) {
            return (Double)value;
        } else {
            if (allowCasting) {
                if (value instanceof Boolean) {
                    if ((Boolean)value) {
                        return 1.0;
                    } else {
                        return 0.0;
                    }
                } else if (value instanceof String) {
                    return Double.valueOf((String)value);
                } else if (value instanceof List<Object>) {
                    return (Double)(((List<Object>)value).size());
                } else if (value instanceof Map<String, Object>) {
                    return (Double)(((Map<String, Object>)value).size());
                } else {
                    throw new CasterException('Unsupported type for casting to Double for value ' + value + ' on {sobjectName}.{fieldName}');
                }
            } else {
                throw new CasterException('Casting disallowed for non-Double value ' + value + ' on {sobjectName}.{fieldName}');
            }
        }
    }

    private static String stringHandler(Object value, Boolean allowCasting) {
        if (value instanceof String) {
            return (String)value;
        } else {
            if (allowCasting) {
                if (value instanceof Boolean) {
                    return String.valueOf((Boolean)value);
                } else if (value instanceof Integer) {
                    return String.valueOf((Integer)value);
                } else if (value instanceof Double) {
                    return String.valueOf((Double)value);
                } else {
                    throw new CasterException('Unsupported type for casting to String for value ' + value + ' on {sobjectName}.{fieldName}');
                }
            } else {
                throw new CasterException('Casting disallowed for non-String value ' + value + ' on {sobjectName}.{fieldName}');
            }
        }
    }

    private static ID idHandler(Object value, Boolean allowCasting) {
        if (value instanceof ID) {
            return (ID)value;
        } else {
            if (allowCasting) {
                if (value instanceof String) {
                    return (ID)value;
                } else {
                    throw new CasterException('Unsupported type for casting to ID for value ' + value + ' on {sobjectName}.{fieldName}');
                }
            } else {
                throw new CasterException('Casting disallowed for non-ID value ' + value + ' on {sobjectName}.{fieldName}');
            }
        }
    }

    private static Date dateHandler(Object value, Boolean allowCasting) {
        if (value instanceof Date) {
            return (Date)value;
        } else {
            if (allowCasting) {
                if (value instanceof String) {
                    try {
                        return Date.parse((String)value);
                    } catch (System.TypeException e) {
                    }
                    try {
                        return Date.valueOf((String)value);
                    } catch (System.TypeException e) {
                        throw new CasterException('Unsupported Date format ' + value + ' on {sobjectName}.{fieldName}');
                    }
                } else {
                    throw new CasterException('Unsupported type for casting to Date for value ' + value + ' on {sobjectName}.{fieldName}');
                }
            } else {
                throw new CasterException('Casting disallowed for non-Date value ' + value + ' on {sobjectName}.{fieldName}');
            }
        }
    }

    private static Time timeHandler(Object value, Boolean allowCasting) {
        if (value instanceof Time) {
            return (Time)value;
        } else {
            if (allowCasting) {
                if (value instanceof String) {
                    Date today = Date.today();
                    Datetime temp = null;
                    String valueString = (String)value;
                    List<String> parts = valueString.split(':');
                    Integer hour = null;
                    Integer minute = null;
                    Integer second = 0;
                    if (parts.size() == 2 || parts.size() == 3) {
                        try {
                            hour = Integer.valueOf(parts.get(0));
                            minute = Integer.valueOf(parts.get(1));
                            if (parts.size() == 3) {
                                second = Integer.valueOf(parts.get(2));
                            }
                        } catch (System.TypeException e) {
                            throw new CasterException('Unsupported Time format ' + valueString + ' on {sobjectName}.{fieldName}');
                        }
                    } else {
                        throw new CasterException('Unsupported Time format ' + valueString + ' on {sobjectName}.{fieldName}');
                    }
                    return Time.newInstance(
                        hour,
                        minute,
                        second,
                        0
                    );
                } else {
                    throw new CasterException('Unsupported type for casting to Time for value ' + value + ' on {sobjectName}.{fieldName}');
                }
            } else {
                throw new CasterException('Casting disallowed for non-Time value ' + value + ' on {sobjectName}.{fieldName}');
            }
        }
    }

    public static Integer sEDMapSize() {
        return edMap.size();
    }

    public WSU_Caster() {
    }

    public void put(sObject sobj, String field, Object value, Boolean allowCasting) {
        sPut(sobj, field, value, allowCasting);
    }

    public void put(sObject sobj, String field, Object value) {
        sPut(sobj, field, value);
    }

    public Integer edMapSize() {
        return sEDMapSize();
    }

    public class CasterException extends Exception {}
}
