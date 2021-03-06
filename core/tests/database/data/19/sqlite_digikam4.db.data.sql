PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE AlbumRoots
                            (id INTEGER PRIMARY KEY,
                            label TEXT,
                            status INTEGER NOT NULL,
                            type INTEGER NOT NULL,
                            identifier TEXT,
                            specificPath TEXT,
                            UNIQUE(identifier, specificPath));
INSERT INTO "AlbumRoots" VALUES(1,NULL,0,1,'volumeid:?uuid=800b21c2-dadc-4930-829e-a96b04ce26fa','/vivo/digikam-devel/data/testimages/a1');
INSERT INTO "AlbumRoots" VALUES(2,'a2',0,1,'volumeid:?uuid=800b21c2-dadc-4930-829e-a96b04ce26fa','/vivo/digikam-devel/data/testimages/a2');
CREATE TABLE Albums
                            (id INTEGER PRIMARY KEY,
                            albumRoot INTEGER NOT NULL,
                            relativePath TEXT NOT NULL,
                            date DATE,
                            caption TEXT,
                            collection TEXT,
                            icon INTEGER,
                            UNIQUE(albumRoot, relativePath));
INSERT INTO "Albums" VALUES(1,1,'/','2011-06-18',NULL,NULL,NULL);
INSERT INTO "Albums" VALUES(2,1,'/jpg','2011-06-23',NULL,NULL,NULL);
INSERT INTO "Albums" VALUES(3,1,'/png','2011-06-23',NULL,NULL,NULL);
INSERT INTO "Albums" VALUES(4,2,'/','2011-06-23',NULL,NULL,NULL);
INSERT INTO "Albums" VALUES(5,2,'/pgf','2011-06-23',NULL,NULL,NULL);
INSERT INTO "Albums" VALUES(6,2,'/pgf/link','2011-06-18',NULL,NULL,NULL);
CREATE TABLE Images
                            (id INTEGER PRIMARY KEY,
                            album INTEGER,
                            name TEXT NOT NULL,
                            status INTEGER NOT NULL,
                            category INTEGER NOT NULL,
                            modificationDate DATETIME,
                            fileSize INTEGER,
                            uniqueHash TEXT,
                            UNIQUE (album, name));
INSERT INTO "Images" VALUES(1,2,'foto001.jpg',1,1,'2011-06-18T16:23:27',126893,'cba2141333c98a6da8d20f44cda6bda8');
INSERT INTO "Images" VALUES(2,2,'foto001bw.jpg',1,1,'2011-06-18T16:24:26',86838,'a398423699151ea8dce74f7158818440');
INSERT INTO "Images" VALUES(3,3,'snap001.png',1,1,'2011-06-23T17:19:40',119878,'84664648e10b81f6234bf89e1a765cfa');
INSERT INTO "Images" VALUES(4,3,'snap002.png',1,1,'2011-06-23T17:19:47',119968,'d7db271ef64e528899e5c30cab4707bc');
INSERT INTO "Images" VALUES(5,4,'Martian_face_viking.jpg',1,1,'2011-06-23T17:20:41',99582,'52f6830591b57137f2bfeb3b181817ed');
INSERT INTO "Images" VALUES(6,5,'foto001.pgf',1,1,'2011-06-18T16:36:49',496246,'7696e970796358ca8b929650bb00dd2d');
INSERT INTO "Images" VALUES(7,6,'foto001.pgf',1,1,'2011-06-18T16:36:49',496246,'7696e970796358ca8b929650bb00dd2d');
INSERT INTO "Images" VALUES(8,6,'lntofoto.pgf',1,1,'2011-06-18T16:36:49',496246,'7696e970796358ca8b929650bb00dd2d');
CREATE TABLE ImageHaarMatrix
                            (imageid INTEGER PRIMARY KEY,
                            modificationDate DATETIME,
                            uniqueHash TEXT,
                            matrix BLOB);
INSERT INTO "ImageHaarMatrix" VALUES(1,'2011-06-18T16:23:27','cba2141333c98a6da8d20f44cda6bda8',X'000000013FD282E4358AE500BF85C943A6CF0565BF81B32654742A72FFFFFF7F00000024FFFFFFDBFFFFFFF700000417FFFFFEFCFFFFFA7DFFFFF97F00000C00000000040000010C0000050B00000201000018800000008DFFFFF980FFFFFF7E000002BBFFFFFFC8FFFFFF79FFFFFFF500000B0700000A0100000287FFFFFFFDFFFFFEF3FFFFFFFE0000001B00000006FFFFFFE4FFFFFFF9FFFFFA800000000DFFFFFD7CFFFFFAFEFFFFFC8000000101FFFFFD7EFFFFFE80FFFFFF000000049400000286FFFFFB7F00000292FFFFFDEE0000090B000005800000008CFFFFF65000000202FFFFFB50FFFFFFA2000004820000020B000002DDFFFFFD38FFFFFAD1FFFFFB23FFFFF700FFFFFEFAFFFFFDDC00000905FFFFFEF40000008900000148FFFFF6520000000C00000484FFFFFF7F0000028CFFFFF6FF000004AFFFFFF675FFFFFFF500000009FFFFFFFFFFFFFE00FFFFFDFFFFFFFF00FFFFFF80FFFFFEEE00000109FFFFFBF9FFFFFDF8FFFFF7000000008CFFFFFFF80000028CFFFFFEE90000010A000001480000002500000009FFFFFDDCFFFFFEEDFFFFFAFEFFFFFEF5FFFFFF75FFFFFEB700000125FFFFFBFC00000205FFFFFB7FFFFFFD7E0000000CFFFFF6FF00000484FFFFFFFC00000181FFFFFDFCFFFFFFF500000180FFFFFB80FFFFFFFFFFFFFDFFFFFFFEFFFFFFFF80FFFFFFFEFFFFFE00FFFFFF00');
INSERT INTO "ImageHaarMatrix" VALUES(2,'2011-06-18T16:24:26','a398423699151ea8dce74f7158818440',X'000000013FD2B32F72FA7D2CBC7240C161E8C145BC641FF2E93A52DB0000058200000024FFFFFFDB00000417FFFFFFF7FFFFFEFCFFFFFA7DFFFFF97F00000C000000050B000018800000010CFFFFFF7EFFFFF980000000040000008DFFFFFFF5000002BBFFFFFFC800000201FFFFFF7900000B0700000A01FFFFFFFE00000287FFFFFEF3FFFFFFFD000000060000001BFFFFFFE4FFFFFFF9FFFFFA800000000DFFFFFD7CFFFFFAFEFFFFFC80FFFFFD7E00000101FFFFFE80FFFFFF00FFFFFF65FFFFFEE3FFFFCF000000068CFFFFF275000006800000000900002D7CFFFFF545FFFFFFFCFFFFEBAB00000104FFFFF4F9FFFFFDFFFFFFFA000000010D0000008700000038FFFFF5FFFFFFFEF4FFFFF40000000002FFFFFAF5FFFFE780FFFFFFE500000AF100000580FFFFFD790000001C0000000300000007FFFFFFFAFFFFFFF3000005020000038000000284FFFFFEFF000002820000018000000100FFFFF4F1FFFFFA8F00002D83FFFFFDFF00001677000016FE000028AB0000051EFFFFFF6500001705FFFFFD7900000087000017AF0000142C000029F100000180000000820000001CFFFFDBD00000285B00002DE3FFFFFFFA00000284FFFFD2710000000200001572FFFFFAF500000AF1000005800000050200000A050000010DFFFFFFF3FFFFFD450000000700000AF200002AF2FFFFFEFF0000028200000100');
INSERT INTO "ImageHaarMatrix" VALUES(3,'2011-06-23T17:19:40','84664648e10b81f6234bf89e1a765cfa',X'000000013FEC2F134075D9C3BF597F9D522E5266BF7060DC9D2AE97E00000301FFFFF87E0000004D00000110000001080000001F00001F0000000D01FFFFFFE000000D0000000D0200000F00FFFFF870FFFFFE7EFFFFF78000002100FFFFEF00FFFFFFDFFFFFF87FFFFFFC7F0000003F00001E80FFFFFE7F00000080000000130000007F00000009FFFFFFBE00000800FFFFFFFCFFFFFF00FFFFFFFEFFFFFFFFFFFFFE0000000180FFFFFC00FFFFFFF8FFFFFFF00000038000000780FFFFF079FFFFF7F5FFFFE4FEFFFFFE480000098BFFFFFDF5000007880000079000001006FFFFE00DFFFFE4FFFFFFDF80FFFFFFFE0000100CFFFFE50000000F90000007F200000F88FFFFF27E000008060000080CFFFFFDFBFFFFEFFBFFFFF27FFFFFFF80FFFFF280FFFFFC48FFFFFFEDFFFFFFF7FFFFFFFCFFFFF7FB00000FF2FFFFF848FFFFF048FFFFFF00FFFFE000FFFFFE00FFFFFC00FFFFF000FFFFF800FFFFFFED0000050CFFFFFCFD0000090600002500FFFFFFF7FFFFFDFEFFFFFBC0FFFFE70000001B020000000100002000FFFFE87500000200FFFFF4FB00000903FFFFF77EFFFFF6FEFFFFFAFE00000D82FFFFE6FDFFFFF380000004020000041600001905FFFFFE800000018500001101FFFFF37DFFFFFBFF00000081FFFFF6FB0000088100000C850000090000000080FFFFFF7E000004000000100000000800');
INSERT INTO "ImageHaarMatrix" VALUES(4,'2011-06-23T17:19:47','d7db271ef64e528899e5c30cab4707bc',X'000000013FEAD6761B7690523F6C3413FB9B03C6BF6D21B2FBA85749FFFFEC7B00001D0200000E0CFFFFFDF100000E0100000F8F00002685FFFFF17F00003A8AFFFFDF00FFFFF180FFFFFBF10000007D0000007CFFFFE3FF00001D0500003886FFFFC779FFFFC57C00001C0000000701FFFFDE80FFFFFF800000000100001F80000003800000003E000001800000000300003F00FFFFF800FFFFEF8000000780FFFFFF000000001F00000007FFFFFE0000000F800000000FFFFFFC00FFFFD873FFFFED7FFFFFECFD000026810000008000000205FFFFF6FA000001030000278100001302FFFFFDFA000027820000138200000481FFFFD8F4FFFFD97E0000010000002700FFFFF680FFFFED00FFFFD8FF0000098C0000268C0000048200001305FFFFEC80FFFFED7AFFFFFDFD000009810000278500001385FFFFD97BFFFFFE000000270300000485FFFFF67DFFFFFB7DFFFFFB80FFFFD87DFFFFD880FFFFD873FFFFF673FFFFED7600002781FFFFFB730000278200001382FFFFED7E00002586FFFFECFDFFFFECFAFFFFD9FAFFFFD97E0000098CFFFFD8F400002700FFFFFDFDFFFFFB7AFFFFD8FF000013020000268CFFFFEC80FFFFF6800000098100001305FFFFED00FFFFFE000000090600001385000027850000048200002703FFFFD97B00000485FFFFF67D00001286FFFFD87DFFFFD880FFFFFB7DFFFFFB80');
INSERT INTO "ImageHaarMatrix" VALUES(5,'2011-06-23T17:20:41','52f6830591b57137f2bfeb3b181817ed',X'000000013FE12F23499E0F60BC80F30ADA6DFB3EBC7381945ACE1B5E0000050C00000684FFFFFD7DFFFFFEE8000000850000008AFFFFFD00FFFFF180FFFFFF6700000393FFFFFFFA00000787FFFFFC7C0000018FFFFFF8720000038F0000018AFFFFFF77FFFFFF7AFFFFFCFD00000185FFFFF900FFFFFCF300000309FFFFFA7AFFFFFC7200000100FFFFFFFBFFFFFFF100000181FFFFFE77FFFFFF7F00000780FFFFFCFFFFFFFE7EFFFFFFF900000304FFFFFF7EFFFFFFFDFFFFFFFFFFFFF17D0000008100000381FFFFE261FFFFE1E1FFFFE43200003BBA00001EFDFFFFFE7F00000586FFFFFE7600000189FFFFC47900003BF4FFFFF8810000078E0000000F000003010000038E0000020600000F77FFFFFC6DFFFFC4CFFFFFF8790000078300000005FFFFFEE7000007040000008900000303FFFFF8FD00000700FFFFC408FFFFF8800000000700000182FFFFFCFC00000082000000010000000300000C02FFFFF974000000890000039C00000E9DFFFFFC6200000005FFFFF880FFFFFDFF00001D8000001D9DFFFFDCCA0000197F00001BCC0000078E000010A80000097A00000084FFFFFA420000083200001E77FFFFFF00FFFFF8710000000BFFFFFDFEFFFFC3810000038400000704000000060000038300000183000001890000008600000301FFFFFCFC0000008200000182000000810000000300000001');
INSERT INTO "ImageHaarMatrix" VALUES(6,'2011-06-18T16:36:49','7696e970796358ca8b929650bb00dd2d',X'000000013FD26402104F5F90BF851BD798BF3CC3BF8169EE61F58BD700000024FFFFFF7FFFFFFFF7FFFFFA7D00000600FFFFFEFC000004170000050B00000004000002010000008DFFFFF97F0000010CFFFFF980FFFFFF7E00000C00000002BBFFFFFFC8FFFFFF79FFFFFFF500000A0100000B070000188000000287FFFFFFFDFFFFFEF3FFFFFFFE0000001B00000006FFFFFFE4FFFFFA80FFFFFFF90000000DFFFFFD7CFFFFFAFEFFFFFC8000000101FFFFFD7EFFFFFE80FFFFFF0000000905000005180000008C00000530FFFFFB6EFFFFFF7500000580FFFFFB80FFFFFDEEFFFFF700FFFFFFE9FFFFFE80FFFFFDDC000004AF00000292000002890000048200000286000002020000021700000205FFFFFB7F000000250000090B0000028CFFFFFEFA0000048400000089FFFFFF7F0000000CFFFFFEF4FFFFF6FFFFFFF675FFFFFFF500000009FFFFFFFFFFFFFDFFFFFFFE00FFFFFF00FFFFFF80FFFFF67BFFFFFEEDFFFFFDEEFFFFFFE9FFFFFEEEFFFFFFF800000A0C0000028CFFFFF97EFFFFF700FFFFFBF9FFFFFDDCFFFFFEE90000010AFFFFFDF4FFFFF6FFFFFFFEF5FFFFFBFC000000A5FFFFFB7FFFFFFF7500000484FFFFFD7E00000025FFFFFDFC0000000C00000181FFFFFFFC00000205FFFFFFF50000012500000180FFFFFB80FFFFFFFFFFFFFDFFFFFFFF80FFFFFEFFFFFFFFFEFFFFFE00FFFFFF00');
INSERT INTO "ImageHaarMatrix" VALUES(7,'2011-06-18T16:36:49','7696e970796358ca8b929650bb00dd2d',X'000000013FD26402104F5F90BF851BD798BF3CC3BF8169EE61F58BD700000024FFFFFF7FFFFFFFF7FFFFFA7D00000600FFFFFEFC000004170000050B00000004000002010000008DFFFFF97F0000010CFFFFF980FFFFFF7E00000C00000002BBFFFFFFC8FFFFFF79FFFFFFF500000A0100000B070000188000000287FFFFFFFDFFFFFEF3FFFFFFFE0000001B00000006FFFFFFE4FFFFFA80FFFFFFF90000000DFFFFFD7CFFFFFAFEFFFFFC8000000101FFFFFD7EFFFFFE80FFFFFF0000000905000005180000008C00000530FFFFFB6EFFFFFF7500000580FFFFFB80FFFFFDEEFFFFF700FFFFFFE9FFFFFE80FFFFFDDC000004AF00000292000002890000048200000286000002020000021700000205FFFFFB7F000000250000090B0000028CFFFFFEFA0000048400000089FFFFFF7F0000000CFFFFFEF4FFFFF6FFFFFFF675FFFFFFF500000009FFFFFFFFFFFFFDFFFFFFFE00FFFFFF00FFFFFF80FFFFF67BFFFFFEEDFFFFFDEEFFFFFFE9FFFFFEEEFFFFFFF800000A0C0000028CFFFFF97EFFFFF700FFFFFBF9FFFFFDDCFFFFFEE90000010AFFFFFDF4FFFFF6FFFFFFFEF5FFFFFBFC000000A5FFFFFB7FFFFFFF7500000484FFFFFD7E00000025FFFFFDFC0000000C00000181FFFFFFFC00000205FFFFFFF50000012500000180FFFFFB80FFFFFFFFFFFFFDFFFFFFFF80FFFFFEFFFFFFFFFEFFFFFE00FFFFFF00');
INSERT INTO "ImageHaarMatrix" VALUES(8,'2011-06-18T16:36:49','7696e970796358ca8b929650bb00dd2d',X'000000013FD26402104F5F90BF851BD798BF3CC3BF8169EE61F58BD700000024FFFFFF7FFFFFFFF7FFFFFA7D00000600FFFFFEFC000004170000050B00000004000002010000008DFFFFF97F0000010CFFFFF980FFFFFF7E00000C00000002BBFFFFFFC8FFFFFF79FFFFFFF500000A0100000B070000188000000287FFFFFFFDFFFFFEF3FFFFFFFE0000001B00000006FFFFFFE4FFFFFA80FFFFFFF90000000DFFFFFD7CFFFFFAFEFFFFFC8000000101FFFFFD7EFFFFFE80FFFFFF0000000905000005180000008C00000530FFFFFB6EFFFFFF7500000580FFFFFB80FFFFFDEEFFFFF700FFFFFFE9FFFFFE80FFFFFDDC000004AF00000292000002890000048200000286000002020000021700000205FFFFFB7F000000250000090B0000028CFFFFFEFA0000048400000089FFFFFF7F0000000CFFFFFEF4FFFFF6FFFFFFF675FFFFFFF500000009FFFFFFFFFFFFFDFFFFFFFE00FFFFFF00FFFFFF80FFFFF67BFFFFFEEDFFFFFDEEFFFFFFE9FFFFFEEEFFFFFFF800000A0C0000028CFFFFF97EFFFFF700FFFFFBF9FFFFFDDCFFFFFEE90000010AFFFFFDF4FFFFF6FFFFFFFEF5FFFFFBFC000000A5FFFFFB7FFFFFFF7500000484FFFFFD7E00000025FFFFFDFC0000000C00000181FFFFFFFC00000205FFFFFFF50000012500000180FFFFFB80FFFFFFFFFFFFFDFFFFFFFF80FFFFFEFFFFFFFFFEFFFFFE00FFFFFF00');
CREATE TABLE ImageInformation
                            (imageid INTEGER PRIMARY KEY,
                            rating INTEGER,
                            creationDate DATETIME,
                            digitizationDate DATETIME,
                            orientation INTEGER,
                            width INTEGER,
                            height INTEGER,
                            format TEXT,
                            colorDepth INTEGER,
                colorModel INTEGER);
INSERT INTO "ImageInformation" VALUES(1,-1,'2011-06-18T16:23:27','2011-06-18T16:23:27',0,720,479,'JPG',8,5);
INSERT INTO "ImageInformation" VALUES(2,-1,'2011-06-18T16:24:26',NULL,0,720,479,'JPG',8,2);
INSERT INTO "ImageInformation" VALUES(3,-1,'2011-06-18T16:24:54','2011-06-18T16:24:54',0,1920,1080,'PNG',8,4);
INSERT INTO "ImageInformation" VALUES(4,-1,'2011-06-18T16:25:00','2011-06-18T16:25:00',0,824,3271,'PNG',8,4);
INSERT INTO "ImageInformation" VALUES(5,-1,'2011-06-18T16:40:36','2011-06-18T16:40:36',0,640,472,'JPG',8,2);
INSERT INTO "ImageInformation" VALUES(6,-1,'2011-06-18T16:36:49','2011-06-18T16:36:49',0,720,479,'PGF',24,1);
INSERT INTO "ImageInformation" VALUES(7,-1,'2011-06-18T16:36:49','2011-06-18T16:36:49',0,720,479,'PGF',24,1);
INSERT INTO "ImageInformation" VALUES(8,-1,'2011-06-18T16:36:49','2011-06-18T16:36:49',0,720,479,'PGF',24,1);
CREATE TABLE ImageMetadata
                            (imageid INTEGER PRIMARY KEY,
                            make TEXT,
                            model TEXT,
                            lens TEXT,
                            aperture REAL,
                            focalLength REAL,
                            focalLength35 REAL,
                            exposureTime REAL,
                            exposureProgram INTEGER,
                            exposureMode INTEGER,
                            sensitivity INTEGER,
                            flash INTEGER,
                            whiteBalance INTEGER,
                            whiteBalanceColorTemperature INTEGER,
                            meteringMode INTEGER,
                            subjectDistance REAL,
                            subjectDistanceCategory INTEGER);
CREATE TABLE ImagePositions
                            (imageid INTEGER PRIMARY KEY,
                            latitude TEXT,
                            latitudeNumber REAL,
                            longitude TEXT,
                            longitudeNumber REAL,
                            altitude REAL,
                            orientation REAL,
                            tilt REAL,
                            roll REAL,
                            accuracy REAL,
                            description TEXT);
CREATE TABLE ImageComments
                            (id INTEGER PRIMARY KEY,
                            imageid INTEGER,
                            type INTEGER,
                            language TEXT,
                            author TEXT,
                            date DATETIME,
                            comment TEXT,
                            UNIQUE(imageid, type, language, author));
INSERT INTO "ImageComments" VALUES(1,1,1,'x-default',NULL,NULL,'This file is a part of digiKam project
https://www.digikam.org
Copyright (C) 2011 by Francesco Riosa <francesco+kde at pnpitalia it>');
INSERT INTO "ImageComments" VALUES(2,2,1,'x-default',NULL,NULL,'This file is a part of digiKam project
https://www.digikam.org
Copyright (C) 2011 by Francesco Riosa <francesco+kde at pnpitalia it>');
CREATE TABLE ImageCopyright
                            (id INTEGER PRIMARY KEY,
                            imageid INTEGER,
                            property TEXT,
                            value TEXT,
                            extraValue TEXT,
                            UNIQUE(imageid, property, value, extraValue));
CREATE TABLE Tags
                            (id INTEGER PRIMARY KEY,
                            pid INTEGER,
                            name TEXT NOT NULL,
                            icon INTEGER,
                            iconkde TEXT,
                            UNIQUE (name, pid));
INSERT INTO "Tags" VALUES(1,0,'tagl0a',0,NULL);
INSERT INTO "Tags" VALUES(2,1,'tagl1a',0,NULL);
INSERT INTO "Tags" VALUES(3,1,'tagl1b',0,NULL);
INSERT INTO "Tags" VALUES(4,1,'tagl1c',0,NULL);
INSERT INTO "Tags" VALUES(5,3,'tagl2a',0,NULL);
INSERT INTO "Tags" VALUES(6,3,'tagl2b',0,NULL);
INSERT INTO "Tags" VALUES(7,3,'tagl2c',0,NULL);
INSERT INTO "Tags" VALUES(8,3,'tagl2d',0,NULL);
INSERT INTO "Tags" VALUES(9,6,'tagl3a',0,NULL);
INSERT INTO "Tags" VALUES(10,6,'tagl3b',0,NULL);
INSERT INTO "Tags" VALUES(11,0,'tl0',0,NULL);
INSERT INTO "Tags" VALUES(12,11,'tl0a',0,NULL);
INSERT INTO "Tags" VALUES(13,11,'tl0b',0,NULL);
INSERT INTO "Tags" VALUES(14,12,'tl0a0',0,NULL);
INSERT INTO "Tags" VALUES(15,12,'tl0a1',0,NULL);
INSERT INTO "Tags" VALUES(16,0,'_Digikam_Internal_Tags_',0,NULL);
INSERT INTO "Tags" VALUES(17,16,'Need Resolving History',0,NULL);
INSERT INTO "Tags" VALUES(18,16,'Need Tagging History Graph',0,NULL);
INSERT INTO "Tags" VALUES(19,0,'People',0,NULL);
INSERT INTO "Tags" VALUES(20,19,'Unknown',0,NULL);
INSERT INTO "Tags" VALUES(21,16,'Original Version',0,NULL);
INSERT INTO "Tags" VALUES(22,16,'Intermediate Version',0,NULL);
INSERT INTO "Tags" VALUES(23,16,'Current Version',0,NULL);
INSERT INTO "Tags" VALUES(24,16,'Version Always Visible',0,NULL);
INSERT INTO "Tags" VALUES(25,16,'Color Label None',0,NULL);
INSERT INTO "Tags" VALUES(26,16,'Color Label Red',0,NULL);
INSERT INTO "Tags" VALUES(27,16,'Color Label Orange',0,NULL);
INSERT INTO "Tags" VALUES(28,16,'Color Label Yellow',0,NULL);
INSERT INTO "Tags" VALUES(29,16,'Color Label Green',0,NULL);
INSERT INTO "Tags" VALUES(30,16,'Color Label Blue',0,NULL);
INSERT INTO "Tags" VALUES(31,16,'Color Label Magenta',0,NULL);
INSERT INTO "Tags" VALUES(32,16,'Color Label Gray',0,NULL);
INSERT INTO "Tags" VALUES(33,16,'Color Label Black',0,NULL);
INSERT INTO "Tags" VALUES(34,16,'Color Label White',0,NULL);
INSERT INTO "Tags" VALUES(35,16,'Pick Label None',0,NULL);
INSERT INTO "Tags" VALUES(36,16,'Pick Label Rejected',0,NULL);
INSERT INTO "Tags" VALUES(37,16,'Pick Label Pending',0,NULL);
INSERT INTO "Tags" VALUES(38,16,'Pick Label Accepted',0,NULL);
CREATE TABLE TagsTree
                            (id INTEGER NOT NULL,
                            pid INTEGER NOT NULL,
                            UNIQUE (id, pid));
INSERT INTO "TagsTree" VALUES(1,0);
INSERT INTO "TagsTree" VALUES(2,0);
INSERT INTO "TagsTree" VALUES(2,1);
INSERT INTO "TagsTree" VALUES(3,0);
INSERT INTO "TagsTree" VALUES(3,1);
INSERT INTO "TagsTree" VALUES(4,0);
INSERT INTO "TagsTree" VALUES(4,1);
INSERT INTO "TagsTree" VALUES(5,0);
INSERT INTO "TagsTree" VALUES(5,1);
INSERT INTO "TagsTree" VALUES(5,3);
INSERT INTO "TagsTree" VALUES(6,0);
INSERT INTO "TagsTree" VALUES(6,1);
INSERT INTO "TagsTree" VALUES(6,3);
INSERT INTO "TagsTree" VALUES(7,0);
INSERT INTO "TagsTree" VALUES(7,1);
INSERT INTO "TagsTree" VALUES(7,3);
INSERT INTO "TagsTree" VALUES(8,0);
INSERT INTO "TagsTree" VALUES(8,1);
INSERT INTO "TagsTree" VALUES(8,3);
INSERT INTO "TagsTree" VALUES(9,0);
INSERT INTO "TagsTree" VALUES(9,1);
INSERT INTO "TagsTree" VALUES(9,3);
INSERT INTO "TagsTree" VALUES(9,6);
INSERT INTO "TagsTree" VALUES(10,0);
INSERT INTO "TagsTree" VALUES(10,1);
INSERT INTO "TagsTree" VALUES(10,3);
INSERT INTO "TagsTree" VALUES(10,6);
INSERT INTO "TagsTree" VALUES(11,0);
INSERT INTO "TagsTree" VALUES(12,0);
INSERT INTO "TagsTree" VALUES(12,11);
INSERT INTO "TagsTree" VALUES(13,0);
INSERT INTO "TagsTree" VALUES(13,11);
INSERT INTO "TagsTree" VALUES(14,0);
INSERT INTO "TagsTree" VALUES(14,11);
INSERT INTO "TagsTree" VALUES(14,12);
INSERT INTO "TagsTree" VALUES(15,0);
INSERT INTO "TagsTree" VALUES(15,11);
INSERT INTO "TagsTree" VALUES(15,12);
INSERT INTO "TagsTree" VALUES(16,0);
INSERT INTO "TagsTree" VALUES(17,0);
INSERT INTO "TagsTree" VALUES(17,16);
INSERT INTO "TagsTree" VALUES(18,0);
INSERT INTO "TagsTree" VALUES(18,16);
INSERT INTO "TagsTree" VALUES(19,0);
INSERT INTO "TagsTree" VALUES(20,0);
INSERT INTO "TagsTree" VALUES(20,19);
INSERT INTO "TagsTree" VALUES(21,0);
INSERT INTO "TagsTree" VALUES(21,16);
INSERT INTO "TagsTree" VALUES(22,0);
INSERT INTO "TagsTree" VALUES(22,16);
INSERT INTO "TagsTree" VALUES(23,0);
INSERT INTO "TagsTree" VALUES(23,16);
INSERT INTO "TagsTree" VALUES(24,0);
INSERT INTO "TagsTree" VALUES(24,16);
INSERT INTO "TagsTree" VALUES(25,0);
INSERT INTO "TagsTree" VALUES(25,16);
INSERT INTO "TagsTree" VALUES(26,0);
INSERT INTO "TagsTree" VALUES(26,16);
INSERT INTO "TagsTree" VALUES(27,0);
INSERT INTO "TagsTree" VALUES(27,16);
INSERT INTO "TagsTree" VALUES(28,0);
INSERT INTO "TagsTree" VALUES(28,16);
INSERT INTO "TagsTree" VALUES(29,0);
INSERT INTO "TagsTree" VALUES(29,16);
INSERT INTO "TagsTree" VALUES(30,0);
INSERT INTO "TagsTree" VALUES(30,16);
INSERT INTO "TagsTree" VALUES(31,0);
INSERT INTO "TagsTree" VALUES(31,16);
INSERT INTO "TagsTree" VALUES(32,0);
INSERT INTO "TagsTree" VALUES(32,16);
INSERT INTO "TagsTree" VALUES(33,0);
INSERT INTO "TagsTree" VALUES(33,16);
INSERT INTO "TagsTree" VALUES(34,0);
INSERT INTO "TagsTree" VALUES(34,16);
INSERT INTO "TagsTree" VALUES(35,0);
INSERT INTO "TagsTree" VALUES(35,16);
INSERT INTO "TagsTree" VALUES(36,0);
INSERT INTO "TagsTree" VALUES(36,16);
INSERT INTO "TagsTree" VALUES(37,0);
INSERT INTO "TagsTree" VALUES(37,16);
INSERT INTO "TagsTree" VALUES(38,0);
INSERT INTO "TagsTree" VALUES(38,16);
CREATE TABLE ImageTags
                            (imageid INTEGER NOT NULL,
                            tagid INTEGER NOT NULL,
                            UNIQUE (imageid, tagid));
INSERT INTO "ImageTags" VALUES(1,15);
INSERT INTO "ImageTags" VALUES(3,2);
INSERT INTO "ImageTags" VALUES(3,3);
INSERT INTO "ImageTags" VALUES(3,7);
INSERT INTO "ImageTags" VALUES(3,8);
INSERT INTO "ImageTags" VALUES(3,10);
INSERT INTO "ImageTags" VALUES(4,5);
INSERT INTO "ImageTags" VALUES(4,12);
INSERT INTO "ImageTags" VALUES(4,14);
CREATE TABLE ImageProperties
                            (imageid  INTEGER NOT NULL,
                            property TEXT    NOT NULL,
                            value    TEXT    NOT NULL,
                            UNIQUE (imageid, property));
CREATE TABLE Searches
                            (id INTEGER PRIMARY KEY,
                            type INTEGER,
                            name TEXT NOT NULL,
                            query TEXT NOT NULL);
INSERT INTO "Searches" VALUES(1,2,'_Current_Search_View_Search_','<?xml version="1.0"?><search><group><field name="albumid" relation="intree">1</field><field name="tagid" relation="intree"><listitem>6</listitem><listitem>5</listitem><listitem>4</listitem><listitem>1</listitem><listitem>3</listitem><listitem>2</listitem><listitem>8</listitem><listitem>7</listitem></field></group></search>
');
INSERT INTO "Searches" VALUES(2,2,'search1','<?xml version="1.0"?><search><group><field name="albumid" relation="intree">1</field><field name="tagid" relation="intree"><listitem>6</listitem><listitem>5</listitem><listitem>4</listitem><listitem>1</listitem><listitem>3</listitem><listitem>2</listitem><listitem>8</listitem><listitem>7</listitem></field></group></search>
');
CREATE TABLE DownloadHistory
                            (id  INTEGER PRIMARY KEY,
                            identifier TEXT,
                            filename TEXT,
                            filesize INTEGER,
                            filedate DATETIME,
                            UNIQUE(identifier, filename, filesize, filedate));
CREATE TABLE Settings
                            (keyword TEXT NOT NULL UNIQUE,
                            value TEXT);
INSERT INTO "Settings" VALUES('preAlpha010Update1','true');
INSERT INTO "Settings" VALUES('preAlpha010Update2','true');
INSERT INTO "Settings" VALUES('preAlpha010Update3','true');
INSERT INTO "Settings" VALUES('beta010Update1','true');
INSERT INTO "Settings" VALUES('beta010Update2','true');
INSERT INTO "Settings" VALUES('databaseUUID','{4fe55531-c919-44ca-9be9-9780398eaac7}');
INSERT INTO "Settings" VALUES('databaseImageFormats','jpg;jpeg;jpe;jp2;j2k;jpx;jpc;pgx;tif;tiff;png;xpm;ppm;pnm;pgf;gif;bmp;xcf;pcx;bay;bmq;cr2;crw;cs1;dc2;dcr;dng;erf;fff;hdr;k25;kdc;mdc;mos;mrw;nef;orf;pef;pxn;raf;raw;rdc;sr2;srf;x3f;arw;3fr;cine;ia;kc2;mef;nrw;qtk;rw2;sti;rwl;srw;');
INSERT INTO "Settings" VALUES('databaseVideoFormats','mpeg;mpg;mpo;mpe;avi;mov;wmf;asf;mp4;3gp;wmv');
INSERT INTO "Settings" VALUES('databaseAudioFormats','ogg;mp3;wma;wav');
INSERT INTO "Settings" VALUES('FilterSettingsVersion','3');
INSERT INTO "Settings" VALUES('DcrawFilterSettingsVersion','4');
INSERT INTO "Settings" VALUES('Locale','ISO-8859-1');
INSERT INTO "Settings" VALUES('DBVersion','6');
INSERT INTO "Settings" VALUES('DBVersionRequired','5');
INSERT INTO "Settings" VALUES('DeleteRemovedCompleteScanCount','8');
INSERT INTO "Settings" VALUES('Scanned','2011-06-24T17:18:28');
INSERT INTO "Settings" VALUES('databaseUserImageFormats',NULL);
INSERT INTO "Settings" VALUES('databaseUserVideoFormats',NULL);
INSERT INTO "Settings" VALUES('databaseUserAudioFormats',NULL);
CREATE TABLE ImageHistory
                            (imageid INTEGER PRIMARY KEY,
                             uuid TEXT,
                             history TEXT);
CREATE TABLE ImageRelations
                            (subject INTEGER,
                             object INTEGER,
                             type INTEGER,
                             UNIQUE(subject, object, type));
CREATE TABLE TagProperties
                            (tagid INTEGER,
                             property TEXT,
                             value TEXT);
INSERT INTO "TagProperties" VALUES(16,'internalTag',NULL);
INSERT INTO "TagProperties" VALUES(17,'internalTag',NULL);
INSERT INTO "TagProperties" VALUES(18,'internalTag',NULL);
INSERT INTO "TagProperties" VALUES(20,'person',NULL);
INSERT INTO "TagProperties" VALUES(20,'unknownPerson',NULL);
INSERT INTO "TagProperties" VALUES(21,'internalTag',NULL);
INSERT INTO "TagProperties" VALUES(22,'internalTag',NULL);
INSERT INTO "TagProperties" VALUES(23,'internalTag',NULL);
INSERT INTO "TagProperties" VALUES(24,'internalTag',NULL);
INSERT INTO "TagProperties" VALUES(25,'internalTag',NULL);
INSERT INTO "TagProperties" VALUES(26,'internalTag',NULL);
INSERT INTO "TagProperties" VALUES(27,'internalTag',NULL);
INSERT INTO "TagProperties" VALUES(28,'internalTag',NULL);
INSERT INTO "TagProperties" VALUES(29,'internalTag',NULL);
INSERT INTO "TagProperties" VALUES(30,'internalTag',NULL);
INSERT INTO "TagProperties" VALUES(31,'internalTag',NULL);
INSERT INTO "TagProperties" VALUES(32,'internalTag',NULL);
INSERT INTO "TagProperties" VALUES(33,'internalTag',NULL);
INSERT INTO "TagProperties" VALUES(34,'internalTag',NULL);
INSERT INTO "TagProperties" VALUES(35,'internalTag',NULL);
INSERT INTO "TagProperties" VALUES(36,'internalTag',NULL);
INSERT INTO "TagProperties" VALUES(37,'internalTag',NULL);
INSERT INTO "TagProperties" VALUES(38,'internalTag',NULL);
CREATE TABLE ImageTagProperties
                            (imageid INTEGER,
                             tagid INTEGER,
                             property TEXT,
                             value TEXT);
CREATE INDEX dir_index  ON Images    (album);
CREATE INDEX hash_index ON Images    (uniqueHash);
CREATE INDEX tag_index  ON ImageTags (tagid);
CREATE TRIGGER delete_albumroot DELETE ON AlbumRoots
                BEGIN
                DELETE FROM Albums
                WHERE Albums.albumRoot = OLD.id;
                END;
CREATE TRIGGER delete_album DELETE ON Albums
                BEGIN
                DELETE FROM Images
                WHERE Images.album = OLD.id;
                END;
CREATE TRIGGER insert_tagstree AFTER INSERT ON Tags
                BEGIN
                INSERT INTO TagsTree
                    SELECT NEW.id, NEW.pid
                    UNION
                    SELECT NEW.id, pid FROM TagsTree WHERE id=NEW.pid;
                END;
CREATE TRIGGER delete_tagstree DELETE ON Tags
                BEGIN
                DELETE FROM Tags
                WHERE id  IN (SELECT id FROM TagsTree WHERE pid=OLD.id);
                DELETE FROM TagsTree
                WHERE id IN (SELECT id FROM TagsTree WHERE pid=OLD.id);
                DELETE FROM TagsTree
                    WHERE id=OLD.id;
                END;
CREATE TRIGGER move_tagstree UPDATE OF pid ON Tags
                BEGIN
                DELETE FROM TagsTree
                    WHERE
                    ((id = OLD.id)
                    OR
                    id IN (SELECT id FROM TagsTree WHERE pid=OLD.id))
                    AND
                    pid IN (SELECT pid FROM TagsTree WHERE id=OLD.id);
                INSERT INTO TagsTree
                    SELECT NEW.id, NEW.pid
                    UNION
                    SELECT NEW.id, pid FROM TagsTree WHERE id=NEW.pid
                    UNION
                    SELECT id, NEW.pid FROM TagsTree WHERE pid=NEW.id
                    UNION
                    SELECT A.id, B.pid FROM TagsTree A, TagsTree B
                    WHERE
                    A.pid = NEW.id AND B.id = NEW.pid;
                END;
CREATE INDEX tag_id_index  ON ImageTags (imageid);
CREATE INDEX image_name_index ON Images (name);
CREATE INDEX creationdate_index ON ImageInformation (creationDate);
CREATE INDEX comments_imageid_index ON ImageComments (imageid);
CREATE INDEX copyright_imageid_index ON ImageCopyright (imageid);
CREATE INDEX uuid_index ON ImageHistory (uuid);
CREATE INDEX subject_relations_index ON ImageRelations (subject);
CREATE INDEX object_relations_index ON ImageRelations (object);
CREATE INDEX tagproperties_index ON TagProperties (tagid);
CREATE INDEX imagetagproperties_index ON ImageTagProperties (imageid, tagid);
CREATE INDEX imagetagproperties_imageid_index ON ImageTagProperties (imageid);
CREATE INDEX imagetagproperties_tagid_index ON ImageTagProperties (tagid);
CREATE TRIGGER delete_image DELETE ON Images
                    BEGIN
                        DELETE FROM ImageTags          WHERE imageid=OLD.id;
                        DELETE From ImageHaarMatrix    WHERE imageid=OLD.id;
                        DELETE From ImageInformation   WHERE imageid=OLD.id;
                        DELETE From ImageMetadata      WHERE imageid=OLD.id;
                        DELETE From ImagePositions     WHERE imageid=OLD.id;
                        DELETE From ImageComments      WHERE imageid=OLD.id;
                        DELETE From ImageCopyright     WHERE imageid=OLD.id;
                        DELETE From ImageProperties    WHERE imageid=OLD.id;
                        DELETE From ImageHistory       WHERE imageid=OLD.id;
                        DELETE FROM ImageRelations     WHERE subject=OLD.id OR object=OLD.id;
                        DELETE FROM ImageTagProperties WHERE imageid=OLD.id;
                        UPDATE Albums SET icon=null    WHERE icon=OLD.id;
                        UPDATE Tags SET icon=null      WHERE icon=OLD.id;
                    END;
CREATE TRIGGER delete_tag DELETE ON Tags
                            BEGIN
                            DELETE FROM ImageTags WHERE tagid=OLD.id;
                            DELETE FROM TagProperties WHERE tagid=OLD.id;
                            DELETE FROM ImageTagProperties WHERE tagid=OLD.id;
                            END;
COMMIT;
