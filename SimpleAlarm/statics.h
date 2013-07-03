//
//  statics.h
//  SimpleAlarm
//
//  Created by chan on 1/31/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//


#import "SimpleAlarmDataBase.h"
#import "DefaultNavigationBar.h"
#import "DateHelper.h"
#import "SimpleAlarmDataBase.h"


//iPhone OS
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5_HEIGTH 1136

#define APPLICATION_VIEW_HEIGHT [[UIScreen mainScreen] applicationFrame].size.height

//DataBase SQLite 
#define DB_NAME @"SIMPLEALARM"
#define DB_SQL_CREATE_TABLE @"CREATE TABLE SIMPLEALARM (id integer NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,type integer NOT NULL DEFAULT 1,cycle varchar(45) NOT NULL,time date NOT NULL,rest_time integer NOT NULL,message varchar(200),ring integer NOT NULL DEFAULT 1,status boolean NOT NULL DEFAULT true,image blob)"
#define DB_SQL_ALARMCLOCKDAO_ADD_ITEM @"INSERT INTO SIMPLEALARM (type,cycle,time,rest_time,message,ring,status,image) VALUES(?,?,?,?,?,?,?,?)"
#define DB_SQL_ALARMCLOCKDAO_UPDATE_ITEM @"UPDATE SIMPLEALARM SET type = ?,cycle = ?,time = ?,rest_time = ?,message = ?,ring = ?,status = ?,image = ? WHERE id = ?"
#define DB_SQL_ALARMCLOCKDAO_DELETE_ITEM @"DELETE FROM SIMPLEALARM WHERE id = ?"
#define DB_SQL_ALARMCLOCKDAO_SELECT_ALL @"SELECT * FROM SIMPLEALARM"

//闹钟Setting键
#define DB_RECORD_SETTING_TYPE          @"db_record_setting_type"
#define DB_RECORD_SETTING_MESSAGE       @"db_record_setting_message"
#define DB_RECORD_SETTING_DATE          @"db_record_setting_date"
#define DB_RECORD_SETTING_CYCLE         @"db_record_setting_cycle"
#define DB_RECORD_SETTING_RESTTIME      @"db_record_setting_resttime"

//MainBoard AlarmList Cell
#define CELL_HEIGHT                 95.0
#define COUNTDOWN_TIP_TODAY         @"今天"
#define COUNTDOWN_TIP_TOMORROW      @"明天"
#define COUNTDOWN_TIP_FUTURE        @"%ld天后"
