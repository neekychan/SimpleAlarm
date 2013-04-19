//
//  statics.h
//  SimpleAlarm
//
//  Created by chan on 1/31/13.
//  Copyright (c) 2013 Cwlay. All rights reserved.
//


#import "SimpleAlarmDataBase.h"
#import "DefaultNavigationBar.h"


//iPhone OS
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5_HEIGTH 1136

//DataBase SQLite 
#define DB_NAME @"SIMPLEALARM"
#define DB_SQL_CREATE_TABLE @"CREATE TABLE SIMPLEALARM (id INTEGER PRIMARY KEY AUTOINCREMENT,type INT NOT NULL ,cycle VARCHAR(45) NOT NULL ,time DATETIME NOT NULL ,rest_time INT NULL ,message VARCHAR(200) NULL)"
#define DB_SQL_ALARMCLOCKDAO_ADD_ITEM @"INSERT INTO SIMPLEALARM (type,cycle,time,rest_time,message) VALUES(%d,%@,%d,%d,%@);"
#define DB_RECORD_SETTING_DATE @"db_record_setting_date"

//MainBoard AlarmList Cell
#define CELL_HEIGHT 95.0
#define COUNTDOWN_TIP_TODAY @"今天"
#define COUNTDOWN_TIP_TOMORROW @"明天"
#define COUNTDOWN_TIP_FUTURE @"%ld天后"
