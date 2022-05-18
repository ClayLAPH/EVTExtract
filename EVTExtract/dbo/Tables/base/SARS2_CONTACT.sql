CREATE TABLE dbo.SARS2_CONTACT 
(
    DIID                                       INT            NOT NULL,
    CONTACTID                                  INT            NOT NULL,
    INSTANCEID                                 INT            NULL,
    RECORDTYPE                                 VARCHAR (2)    NULL,
    RLENT_FIRSTNAME                            VARCHAR (100)  NULL,
    RLENT_LASTNAME                             VARCHAR (100)  NULL,
    RLENT_MIDDLEINITIAL                        VARCHAR (100)  NULL,
    RLENT_NAMESUFFIX                           VARCHAR (50)   NULL,
    RLENT_AGE                                  INT            NULL,
    RLENT_DOB                                  DATETIME       NULL,
    RLENT_SEX                                  VARCHAR (255)  NULL,
    RLENT_CONTACTTYPE                          VARCHAR (255)  NULL,
    RLENT_DATESOFCONTACT                       DATETIME       NULL,
    RLENT_STREETADDRESS                        VARCHAR (100)  NULL,
    RLENT_APARTMENT                            VARCHAR (100)  NULL,
    RLENT_CITY                                 VARCHAR (100)  NULL,
    RLENT_ZIP                                  VARCHAR (100)  NULL,
    RLENT_PHONE                                VARCHAR (100)  NULL,
    RLENT_DISTRICT                             VARCHAR (255)  NULL,
    RLENT_PROPHYLAXISMEDICATION                VARCHAR (MAX) NULL,
    RLENT_INVESTIGATORDR                       VARCHAR (202)  NULL,
    RLENT_EXPEVENTDR                           INT            NULL,
    RLENT_EXPEVENT                             VARCHAR (250)  NULL,
    RLENT_PRIORITYDR                           VARCHAR (255)  NULL,
    RLENT_CLUSTERID                            VARCHAR (MAX) NULL,
    RLENT_STATUSDR                             VARCHAR (255)  NULL,
    FOLDERID                                   INT            NULL,
    RLENT_ELECTRONICCONTACT                    VARCHAR (MAX) NULL,
    RLENT_EMAIL                                VARCHAR (MAX) NULL,
    RLENT_STATE                                VARCHAR (100)  NULL,
    RLENT_RACE                                 VARCHAR (255)  NULL,
    RLENT_PERSONALRECORDDR                     INT            NULL,
    RLENT_PERSONALRECORDID                     VARCHAR (50)   NULL,
    RLENT_PERSONALRECORDTYPE                   VARCHAR (100)  NULL,
    RLENT_CONTACTINVESTIGATIONLINKEDINCIDENTDR INT            NULL,
    RLENT_CONTACTINVESTIGATIONLINKEDINCIDENTID VARCHAR (50)   NULL
);
go
create clustered index [SARS2_CONTACT.DIID.CONTACTID.Fake.PrimaryKey] 
on dbo.SARS2_CONTACT(DIID,CONTACTID);

