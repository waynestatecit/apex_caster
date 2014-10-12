// This file is part of WSU_Caster, an Apex-to-database type casting utility for the Force.com platform.
//
// Copyright 2013-2014, Wayne State University
// License: 3-clause BSD license.  See LICENSE.

@isTest
public class WSU_CasterTest {
    static {
    }

    static testMethod void putBoolean1() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.IsActive, false);
        WSU_Caster.sPut(camp, 'IsActive', true);
        System.assertEquals(camp.IsActive, true);
    }

    static testMethod void putBoolean2() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.IsActive, false);
        WSU_Caster.sPut(camp, 'IsActive', 'lolol');
        System.assertEquals(camp.IsActive, true);
    }

    static testMethod void putBoolean3() {
        Campaign camp = new Campaign(IsActive = true);
        System.assertEquals(camp.IsActive, true);
        WSU_Caster.sPut(camp, 'IsActive', 'F');
        System.assertEquals(camp.IsActive, false);
    }

    static testMethod void putBoolean3_1() {
        Campaign camp = new Campaign(IsActive = true);
        System.assertEquals(camp.IsActive, true);
        WSU_Caster.sPut(camp, 'IsActive', '');
        System.assertEquals(camp.IsActive, false);
    }

    static testMethod void putBoolean4() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.IsActive, false);
        WSU_Caster.sPut(camp, 'IsActive', 1);
        System.assertEquals(camp.IsActive, true);
    }

    static testMethod void putBoolean5() {
        Campaign camp = new Campaign(IsActive = true);
        System.assertEquals(camp.IsActive, true);
        WSU_Caster.sPut(camp, 'IsActive', 0);
        System.assertEquals(camp.IsActive, false);
    }

    static testMethod void putBoolean6() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.IsActive, false);
        WSU_Caster.sPut(camp, 'IsActive', 1987.1234);
        System.assertEquals(camp.IsActive, true);
    }

    static testMethod void putBoolean7() {
        Campaign camp = new Campaign(IsActive = true);
        System.assertEquals(camp.IsActive, true);
        WSU_Caster.sPut(camp, 'IsActive', 0.000);
        System.assertEquals(camp.IsActive, false);
    }

    static testMethod void putBoolean8() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.IsActive, false);
        WSU_Caster.sPut(camp, 'IsActive', new List<String>{'no'});
        System.assertEquals(camp.IsActive, true);
    }

    static testMethod void putBoolean9() {
        Campaign camp = new Campaign(IsActive = true);
        System.assertEquals(camp.IsActive, true);
        WSU_Caster.sPut(camp, 'IsActive', new List<String>());
        System.assertEquals(camp.IsActive, false);
    }

    static testMethod void putBoolean10() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.IsActive, false);
        WSU_Caster.sPut(camp, 'IsActive', new List<sObject>{new Contact(LastName = 'LASTNAME')});
        System.assertEquals(camp.IsActive, true);
    }

    static testMethod void putBoolean11() {
        Campaign camp = new Campaign(IsActive = true);
        System.assertEquals(camp.IsActive, true);
        WSU_Caster.sPut(camp, 'IsActive', new List<sObject>());
        System.assertEquals(camp.IsActive, false);
    }

    static testMethod void putBoolean12() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.IsActive, false);
        WSU_Caster.sPut(camp, 'IsActive', new Map<String, String>{'key1' => 'value1'});
        System.assertEquals(camp.IsActive, true);
    }

    static testMethod void putBoolean13() {
        Campaign camp = new Campaign(IsActive = true);
        System.assertEquals(camp.IsActive, true);
        WSU_Caster.sPut(camp, 'IsActive', new Map<String, String>());
        System.assertEquals(camp.IsActive, false);
    }

    static testMethod void putBoolean14() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.IsActive, false);
        WSU_Caster.sPut(camp, 'IsActive', new Map<String, sObject>{'key1' => new Contact(LastName = 'LASTNAME')});
        System.assertEquals(camp.IsActive, true);
    }

    static testMethod void putBoolean15() {
        Campaign camp = new Campaign(IsActive = true);
        System.assertEquals(camp.IsActive, true);
        WSU_Caster.sPut(camp, 'IsActive', new Map<String, sObject>());
        System.assertEquals(camp.IsActive, false);
    }

    static testMethod void putBoolean16() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.IsActive, false);
        Boolean success = true;
        try {
            WSU_Caster.sPut(camp, 'IsActive', Date.today());
        } catch (WSU_Caster.CasterException e) {
            success = false;
            System.assertEquals(e.getMessage(), 'Unsupported type for casting to Boolean for value ' + Date.today() + ' on Campaign.IsActive');
        }
        System.assert(!success);
    }

    static testMethod void putBoolean17() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.IsActive, false);
        Boolean success = true;
        try {
            WSU_Caster.sPut(camp, 'IsActive', 1, false);
        } catch (WSU_Caster.CasterException e) {
            success = false;
            System.assertEquals(e.getMessage(), 'Casting disallowed for non-Boolean value ' + 1 + ' on Campaign.IsActive');
        }
        System.assert(!success);
    }

    static testMethod void putBooleanInstance1() {
        WSU_Caster ed = new WSU_Caster();
        Campaign camp = new Campaign();
        System.assertEquals(camp.IsActive, false);
        ed.put(camp, 'IsActive', true);
        System.assertEquals(camp.IsActive, true);
    }

    static testMethod void putBooleanInstance2() {
        WSU_Caster ed = new WSU_Caster();
        Campaign camp = new Campaign();
        System.assertEquals(camp.IsActive, false);
        Boolean success = true;
        try {
            ed.put(camp, 'IsActive', 1, false);
        } catch (WSU_Caster.CasterException e) {
            success = false;
            System.assertEquals(e.getMessage(), 'Casting disallowed for non-Boolean value ' + 1 + ' on Campaign.IsActive');
        }
        System.assert(!success);
    }

    static testMethod void putString1() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.Name, null);
        WSU_Caster.sPut(camp, 'Name', 'TestNAME');
        System.assertEquals(camp.Name, 'TestNAME');
    }

    static testMethod void putString2() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.Name, null);
        WSU_Caster.sPut(camp, 'Name', true);
        System.assertEquals(camp.Name, 'true');
    }

    static testMethod void putString3() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.Name, null);
        WSU_Caster.sPut(camp, 'Name', 101);
        System.assertEquals(camp.Name, '101');
    }

    static testMethod void putString4() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.Name, null);
        WSU_Caster.sPut(camp, 'Name', -343.234);
        System.assertEquals(camp.Name, '-343.234');
    }

    static testMethod void putString5() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.Name, null);
        ID testId = '000000000000000000';
        WSU_Caster.sPut(camp, 'Name', testId);
        System.assertEquals(camp.Name, '000000000000000000');
    }

    static testMethod void putString6() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.Name, null);
        Boolean success = true;
        try {
            WSU_Caster.sPut(camp, 'Name', new List<String>());
        } catch (WSU_Caster.CasterException e) {
            success = false;
            System.assertEquals(e.getMessage(), 'Unsupported type for casting to String for value ' + new List<String>() + ' on Campaign.Name');
        }
        System.assert(!success);
    }

    static testMethod void putString7() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.Name, null);
        Boolean success = true;
        try {
            WSU_Caster.sPut(camp, 'Name', new List<String>(), false);
        } catch (WSU_Caster.CasterException e) {
            success = false;
            System.assertEquals(e.getMessage(), 'Casting disallowed for non-String value ' + new List<String>() + ' on Campaign.Name');
        }
        System.assert(!success);
    }

    static testMethod void putInteger1() {
        Account acc = new Account();
        System.assertEquals(acc.NumberOfEmployees, null);
        WSU_Caster.sPut(acc, 'NumberOfEmployees', 123);
        System.assertEquals(acc.NumberOfEmployees, 123);
    }

    static testMethod void putInteger2() {
        Account acc = new Account();
        System.assertEquals(acc.NumberOfEmployees, null);
        WSU_Caster.sPut(acc, 'NumberOfEmployees', 1.123123);
        System.assertEquals(acc.NumberOfEmployees, 1);
    }

    static testMethod void putInteger3() {
        Account acc = new Account();
        System.assertEquals(acc.NumberOfEmployees, null);
        WSU_Caster.sPut(acc, 'NumberOfEmployees', '123');
        System.assertEquals(acc.NumberOfEmployees, 123);
    }

    static testMethod void putInteger4() {
        Account acc = new Account();
        System.assertEquals(acc.NumberOfEmployees, null);
        WSU_Caster.sPut(acc, 'NumberOfEmployees', '2343.6234');
        System.assertEquals(acc.NumberOfEmployees, 2343);
    }

    static testMethod void putInteger5() {
        Account acc = new Account();
        System.assertEquals(acc.NumberOfEmployees, null);
        WSU_Caster.sPut(acc, 'NumberOfEmployees', true);
        System.assertEquals(acc.NumberOfEmployees, 1);
    }

    static testMethod void putInteger6() {
        Account acc = new Account();
        System.assertEquals(acc.NumberOfEmployees, null);
        WSU_Caster.sPut(acc, 'NumberOfEmployees', false);
        System.assertEquals(acc.NumberOfEmployees, 0);
    }

    static testMethod void putInteger7() {
        Account acc = new Account();
        System.assertEquals(acc.NumberOfEmployees, null);
        WSU_Caster.sPut(acc, 'NumberOfEmployees', new List<Decimal>{123.234, 554.1, 23423.0});
        System.assertEquals(acc.NumberOfEmployees, 3);
    }

    static testMethod void putInteger8() {
        Account acc = new Account();
        System.assertEquals(acc.NumberOfEmployees, null);
        WSU_Caster.sPut(acc, 'NumberOfEmployees', new Map<String, sObject>{
            'one' => new Contact(LastName = 'ONE'),
            'two' => new Contact(LastName = 'TWO')
        });
        System.assertEquals(acc.NumberOfEmployees, 2);
    }

    static testMethod void putInteger9() {
        Account acc = new Account();
        System.assertEquals(acc.NumberOfEmployees, null);
        Boolean success = true;
        try {
            WSU_Caster.sPut(acc, 'NumberOfEmployees', Date.today());
        } catch (WSU_Caster.CasterException e) {
            success = false;
            System.assertEquals(e.getMessage(), 'Unsupported type for casting to Integer for value ' + Date.today() + ' on Account.NumberOfEmployees');
        }
        System.assert(!success);
    }

    static testMethod void putInteger10() {
        Account acc = new Account();
        System.assertEquals(acc.NumberOfEmployees, null);
        Boolean success = true;
        try {
            WSU_Caster.sPut(acc, 'NumberOfEmployees', '15', false);
        } catch (WSU_Caster.CasterException e) {
            success = false;
            System.assertEquals(e.getMessage(), 'Casting disallowed for non-Integer value ' + '15' + ' on Account.NumberOfEmployees');
        }
        System.assert(!success);
    }

    static testMethod void putDouble1() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.NumberSent, null);
        WSU_Caster.sPut(camp, 'NumberSent', 123.234);
        System.assertEquals(camp.NumberSent, 123.234);
    }

    static testMethod void putDouble2() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.NumberSent, null);
        WSU_Caster.sPut(camp, 'NumberSent', 1);
        System.assertEquals(camp.NumberSent, 1.0);
    }

    static testMethod void putDouble3() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.NumberSent, null);
        WSU_Caster.sPut(camp, 'NumberSent', '123.908098');
        System.assertEquals(camp.NumberSent, 123.908098);
    }

    static testMethod void putDouble4() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.NumberSent, null);
        WSU_Caster.sPut(camp, 'NumberSent', '2343');
        System.assertEquals(camp.NumberSent, 2343.0);
    }

    static testMethod void putDouble5() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.NumberSent, null);
        WSU_Caster.sPut(camp, 'NumberSent', true);
        System.assertEquals(camp.NumberSent, 1.0);
    }

    static testMethod void putDouble6() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.NumberSent, null);
        WSU_Caster.sPut(camp, 'NumberSent', false);
        System.assertEquals(camp.NumberSent, 0.0);
    }

    static testMethod void putDouble7() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.NumberSent, null);
        WSU_Caster.sPut(camp, 'NumberSent', new List<Decimal>{123.234, 554.1, 23423.0});
        System.assertEquals(camp.NumberSent, 3.0);
    }

    static testMethod void putDouble8() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.NumberSent, null);
        WSU_Caster.sPut(camp, 'NumberSent', new Map<String, sObject>{
            'one' => new Contact(LastName = 'ONE'),
            'two' => new Contact(LastName = 'TWO')
        });
        System.assertEquals(camp.NumberSent, 2.0);
    }

    static testMethod void putDouble9() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.NumberSent, null);
        Boolean success = true;
        try {
            WSU_Caster.sPut(camp, 'NumberSent', Date.today());
        } catch (WSU_Caster.CasterException e) {
            success = false;
            System.assertEquals(e.getMessage(), 'Unsupported type for casting to Double for value ' + Date.today() + ' on Campaign.NumberSent');
        }
        System.assert(!success);
    }

    static testMethod void putDouble10() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.NumberSent, null);
        Boolean success = true;
        try {
            WSU_Caster.sPut(camp, 'NumberSent', '15', false);
        } catch (WSU_Caster.CasterException e) {
            success = false;
            System.assertEquals(e.getMessage(), 'Casting disallowed for non-Double value ' + '15' + ' on Campaign.NumberSent');
        }
        System.assert(!success);
    }

    static testMethod void putDate1() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.EndDate, null);
        WSU_Caster.sPut(camp, 'EndDate', Date.today());
        System.assertEquals(camp.EndDate, Date.today());
    }

    static testMethod void putDate2() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.EndDate, null);
        WSU_Caster.sPut(camp, 'EndDate', '1/4/2011');
        System.assertEquals(camp.EndDate, Date.newInstance(2011, 1, 4));
    }

    static testMethod void putDate3() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.EndDate, null);
        WSU_Caster.sPut(camp, 'EndDate', '1964-11-30 12:21:54');
        System.assertEquals(camp.EndDate, Date.newInstance(1964, 11, 30));
    }

    static testMethod void putDate4() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.EndDate, null);
        Boolean success = true;
        try {
            WSU_Caster.sPut(camp, 'EndDate', 'lkjklj');
        } catch (WSU_Caster.CasterException e) {
            success = false;
            System.assertEquals(e.getMessage(), 'Unsupported Date format ' + 'lkjklj' + ' on Campaign.EndDate');
        }
        System.assert(!success);
    }

    static testMethod void putDate5() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.EndDate, null);
        Boolean success = true;
        try {
            WSU_Caster.sPut(camp, 'EndDate', 123.34);
        } catch (WSU_Caster.CasterException e) {
            success = false;
            System.assertEquals(e.getMessage(), 'Unsupported type for casting to Date for value ' + 123.34 + ' on Campaign.EndDate');
        }
        System.assert(!success);
    }

    static testMethod void putDate6() {
        Campaign camp = new Campaign();
        System.assertEquals(camp.EndDate, null);
        Boolean success = true;
        try {
            WSU_Caster.sPut(camp, 'EndDate', 15, false);
        } catch (WSU_Caster.CasterException e) {
            success = false;
            System.assertEquals(e.getMessage(), 'Casting disallowed for non-Date value ' + 15 + ' on Campaign.EndDate');
        }
        System.assert(!success);
    }

    static testMethod void putTime1() {
        BusinessHours bh = new BusinessHours();
        System.assertEquals(bh.FridayStartTime, null);
        WSU_Caster.sPut(bh, 'FridayStartTime', Time.newInstance(9, 30, 1, 0));
        System.assertEquals(bh.FridayStartTime, Time.newInstance(9, 30, 1, 0));
    }

    static testMethod void putTime2() {
        BusinessHours bh = new BusinessHours();
        System.assertEquals(bh.FridayStartTime, null);
        WSU_Caster.sPut(bh, 'FridayStartTime', '12:34');
        System.assertEquals(bh.FridayStartTime, Time.newInstance(12, 34, 0, 0));
    }

    static testMethod void putTime3() {
        BusinessHours bh = new BusinessHours();
        System.assertEquals(bh.FridayStartTime, null);
        WSU_Caster.sPut(bh, 'FridayStartTime', '2:12:59');
        System.assertEquals(bh.FridayStartTime, Time.newInstance(2, 12, 59, 0));
    }

    static testMethod void putTime4() {
        BusinessHours bh = new BusinessHours();
        System.assertEquals(bh.FridayStartTime, null);
        Boolean success = true;
        try {
            WSU_Caster.sPut(bh, 'FridayStartTime', 'lkjklj');
        } catch (WSU_Caster.CasterException e) {
            success = false;
            System.assertEquals(e.getMessage(), 'Unsupported Time format ' + 'lkjklj' + ' on BusinessHours.FridayStartTime');
        }
        System.assert(!success);
    }

    static testMethod void putTime5() {
        BusinessHours bh = new BusinessHours();
        System.assertEquals(bh.FridayStartTime, null);
        Boolean success = true;
        try {
            WSU_Caster.sPut(bh, 'FridayStartTime', '13:4j');
        } catch (WSU_Caster.CasterException e) {
            success = false;
            System.assertEquals(e.getMessage(), 'Unsupported Time format ' + '13:4j' + ' on BusinessHours.FridayStartTime');
        }
        System.assert(!success);
    }

    static testMethod void putTime6() {
        BusinessHours bh = new BusinessHours();
        System.assertEquals(bh.FridayStartTime, null);
        Boolean success = true;
        try {
            WSU_Caster.sPut(bh, 'FridayStartTime', 123.34);
        } catch (WSU_Caster.CasterException e) {
            success = false;
            System.assertEquals(e.getMessage(), 'Unsupported type for casting to Time for value ' + 123.34 + ' on BusinessHours.FridayStartTime');
        }
        System.assert(!success);
    }

    static testMethod void putTime7() {
        BusinessHours bh = new BusinessHours();
        System.assertEquals(bh.FridayStartTime, null);
        Boolean success = true;
        try {
            WSU_Caster.sPut(bh, 'FridayStartTime', 15, false);
        } catch (WSU_Caster.CasterException e) {
            success = false;
            System.assertEquals(e.getMessage(), 'Casting disallowed for non-Time value ' + 15 + ' on BusinessHours.FridayStartTime');
        }
        System.assert(!success);
    }

    static testMethod void putID1() {
        CampaignMember cm = new CampaignMember();
        Lead ld = new Lead(LastName = 'LASTNAMELEAD1', Company = 'COMPANY1');
        insert ld;
        System.assertEquals(cm.LeadId, null);
        WSU_Caster.sPut(cm, 'LeadId', ld.Id);
        System.assertEquals(cm.LeadId, ld.Id);
    }

    static testMethod void putID2() {
        CampaignMember cm = new CampaignMember();
        Lead ld = new Lead(LastName = 'LASTNAMELEAD1', Company = 'COMPANY1');
        insert ld;
        System.assertEquals(cm.LeadId, null);
        WSU_Caster.sPut(cm, 'LeadId', (String)ld.Id);
        System.assertEquals(cm.LeadId, ld.Id);
    }

    static testMethod void putID3() {
        CampaignMember cm = new CampaignMember();
        System.assertEquals(cm.LeadId, null);
        Boolean success = true;
        try {
            WSU_Caster.sPut(cm, 'LeadId', Date.today());
        } catch (WSU_Caster.CasterException e) {
            success = false;
            System.assertEquals(e.getMessage(), 'Unsupported type for casting to ID for value ' + Date.today() + ' on CampaignMember.LeadId');
        }
        System.assert(!success);
    }

    static testMethod void putID4() {
        CampaignMember cm = new CampaignMember();
        System.assertEquals(cm.LeadId, null);
        Boolean success = true;
        try {
            WSU_Caster.sPut(cm, 'LeadId', 'ateststring', false);
        } catch (WSU_Caster.CasterException e) {
            success = false;
            System.assertEquals(e.getMessage(), 'Casting disallowed for non-ID value ' + 'ateststring' + ' on CampaignMember.LeadId');
        }
        System.assert(!success);
    }

    static testMethod void missingEDs1() {
        Integer oldSize = WSU_Caster.sEDMapSize();
        Contact con = new Contact();
        System.assertEquals(con.LastName, null);
        WSU_Caster.sPut(con, 'LastName', 'TestNAME');
        System.assertEquals(con.LastName, 'TestNAME');
        Integer newSize = WSU_Caster.sEDMapSize();
        System.assertEquals(newSize, oldSize + 1);
    }

    static testMethod void missingEDsInstance1() {
        WSU_Caster ed = new WSU_Caster();
        Integer oldSize = ed.edMapSize();
        Contact con = new Contact();
        System.assertEquals(con.LastName, null);
        ed.put(con, 'LastName', 'TestNAME');
        System.assertEquals(con.LastName, 'TestNAME');
        Integer newSize = ed.edMapSize();
        System.assertEquals(newSize, oldSize + 1);
    }
}
