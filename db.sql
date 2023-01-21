CREATE DATABASE IF NOT EXISTS `uas` DEFAULT CHARACTER SET utf8mb4 COLLATE
utf8mb4_unicode_520_ci;
USE `uas`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getStaffCount` () BEGIN
SELECT position AS Position, COUNT(position) AS EmpCount
FROM accomstaff
GROUP BY position;
END$$
DELIMITER ;
CREATE TABLE `accomstaff` (
 `staffNo` int(11) NOT NULL,
 `fName` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `lName` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `street` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `city` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `postcode` char(4) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `DOB` date NOT NULL,
 `sex` enum('Male','Female') COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `position` enum('Hall Manager','Administrative Assisstant','Cleaner') COLLATE utf8mb4_unicode_520_ci NOT
NULL,
 `locaton` enum('Accommodation Office','Hall') COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
CREATE TABLE `advisor` (
 `advisorNo` int(11) NOT NULL,
 `fName` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `lName` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `positon` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `department` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `intTelNo` char(12) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `roomNo` char(4) COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
CREATE TABLE `course` (
 `courseNo` int(11) NOT NULL,
 `title` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `lFName` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `lLName` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `intTelNo` char(12) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `roomNo` char(4) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `department` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
CREATE TABLE `flatroom` (
 `flatPlaceNo` int(11) NOT NULL,
 `roomNo` char(4) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `rentalRate` decimal(11,4) NOT NULL,
 `flatNo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
CREATE TABLE `hallroom` (
 `hallPlaceNo` int(11) NOT NULL,
 `roomNo` char(4) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `rentalRate` decimal(11,4) NOT NULL,
 `hallNo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
CREATE TABLE `inspection` (
 `staffNo` int(11) NOT NULL,
 `inspectonDate` date NOT NULL,
 `sConditon` enum('Yes','No') COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `comment` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
 `flatNo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
CREATE TABLE `invoice` (
 `invoiceNo` int(11) NOT NULL,
 `semester` enum('First Semester','Second Semester','Summer Semester') COLLATE utf8mb4_unicode_520_ci NOT
NULL,
 `dueDate` date NOT NULL,
 `amount` decimal(11,4) NOT NULL,
 `leaseNo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
CREATE TABLE `lease` (
 `leaseNo` int(11) NOT NULL,
 `duration` enum('Up To First Semester','Up To Second Semester','Up to Summer Semester') COLLATE
utf8mb4_unicode_520_ci NOT NULL,
 `dateMoveIn` date NOT NULL,
 `dateMoveOut` date DEFAULT NULL,
 `studentNo` int(11) NOT NULL,
 `hallPlaceNo` int(11) DEFAULT NULL,
 `flatPlaceNo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
DELIMITER $$
CREATE TRIGGER `updateMade` BEFORE UPDATE ON `lease` FOR EACH ROW BEGIN
INSERT INTO update_logs(action, action_time, data1)
VALUES(CONCAT('update from leaseNo: ', OLD.leaseNo), NOW(),
OLD.duration);
END
$$
DELIMITER ;
CREATE TABLE `nok` (
 `studentNo` int(11) NOT NULL,
 `fName` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `lName` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `relationship` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `street` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `city` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `postcode` char(4) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `contactNo` char(12) COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
CREATE TABLE `payment` (
 `datePaid` date NOT NULL,
 `paymentMethod` enum('Cheque','Cash','Digital') COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `invoiceNo` int(11) NOT NULL,
 `studentNo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
CREATE TABLE `paymentreminder` (
 `reminderDate` date NOT NULL,
 `invoiceNo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
CREATE TABLE `residencehall` (
 `hallNo` int(11) NOT NULL,
 `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `street` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `city` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `postcode` char(4) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `telNo` char(12) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `HMStaffNo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
CREATE TABLE `student` (
 `studentNo` int(11) NOT NULL,
 `fName` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `lName` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `street` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `city` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `postcode` char(4) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `DOB` date NOT NULL,
 `sex` enum('Male','Female') COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `category` enum('Undergraduate Student','Masters Student','PHD Student') COLLATE utf8mb4_unicode_520_ci
NOT NULL,
 `natonality` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `smoker` enum('Yes','No') COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `specialNeeds` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
 `comment` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
 `accomStatus` enum('Placed','Waiting') COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `courseNo` int(11) NOT NULL,
 `advisorNo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
CREATE TABLE `studentflat` (
 `flatNo` int(11) NOT NULL,
 `street` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `city` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `postcode` char(4) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `noOfSingleBR` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
CREATE TABLE `update_logs` (
 `logId` int(11) NOT NULL,
 `action` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
 `action_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
 `data1` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
CREATE TABLE `vallhallmanager` (
`hallNo` int(11)
,`name` varchar(255)
,`telNo` char(12)
,`fName` varchar(255)
,`lName` varchar(255)
);
CREATE TABLE `v_lease_info` (
`studentNo` int(11)
,`fname` varchar(255)
,`lname` varchar(255)
,`leaseno` int(11)
,`duration` enum('Up To First Semester','Up To Second Semester','Up to Summer Semester')
,`datemoveout` date
);
CREATE TABLE `with_summer_sem` (
`leaseNo` int(11)
,`duration` enum('Up To First Semester','Up To Second Semester','Up to Summer Semester')
,`dateMoveIn` date
,`dateMoveOut` date
,`studentNo` int(11)
,`hallPlaceNo` int(11)
,`flatPlaceNo` int(11)
);
DROP TABLE IF EXISTS `vallhallmanager`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW
`vallhallmanager` AS SELECT `residencehall`.`hallNo` AS `hallNo`, `residencehall`.`name` AS `name`,
`residencehall`.`telNo` AS `telNo`, `accomstaff`.`fName` AS `fName`, `accomstaff`.`lName` AS `lName` FROM
(`residencehall` join `accomstaff` on(`residencehall`.`HMStaffNo` = `accomstaff`.`staffNo`)) ;
DROP TABLE IF EXISTS `v_lease_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW
`v_lease_info` AS SELECT `student`.`studentNo` AS `studentNo`, `student`.`fName` AS `fname`, `student`.`lName`
AS `lname`, `lease`.`leaseNo` AS `leaseno`, `lease`.`duration` AS `duration`, `lease`.`dateMoveOut` AS `datemoveout`
FROM (`lease` join `student` on(`lease`.`studentNo` = `student`.`studentNo`)) ;
DROP TABLE IF EXISTS `with_summer_sem`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW
`with_summer_sem` AS SELECT `lease`.`leaseNo` AS `leaseNo`, `lease`.`duration` AS `duration`,
`lease`.`dateMoveIn` AS `dateMoveIn`, `lease`.`dateMoveOut` AS `dateMoveOut`, `lease`.`studentNo` AS
`studentNo`, `lease`.`hallPlaceNo` AS `hallPlaceNo`, `lease`.`flatPlaceNo` AS `flatPlaceNo` FROM `lease` WHERE
`lease`.`duration` = 'Up to Summer Semester' ;
ALTER TABLE `accomstaff`
 ADD PRIMARY KEY (`staffNo`);
ALTER TABLE `advisor`
 ADD PRIMARY KEY (`advisorNo`);
ALTER TABLE `course`
 ADD PRIMARY KEY (`courseNo`);
ALTER TABLE `flatroom`
 ADD PRIMARY KEY (`flatPlaceNo`),
 ADD KEY `flatNo` (`flatNo`);
ALTER TABLE `hallroom`
 ADD PRIMARY KEY (`hallPlaceNo`),
 ADD KEY `hallNo` (`hallNo`);
ALTER TABLE `inspection`
 ADD KEY `staffNo` (`staffNo`),
 ADD KEY `flatNo` (`flatNo`);
ALTER TABLE `invoice`
 ADD PRIMARY KEY (`invoiceNo`),
 ADD KEY `leaseNo` (`leaseNo`);
ALTER TABLE `lease`
 ADD PRIMARY KEY (`leaseNo`),
 ADD KEY `studentNo` (`studentNo`),
 ADD KEY `hallPlaceNo` (`hallPlaceNo`),
 ADD KEY `flatPlaceNo` (`flatPlaceNo`);
ALTER TABLE `nok`
 ADD KEY `studentNo` (`studentNo`);
ALTER TABLE `payment`
 ADD KEY `invoiceNo` (`invoiceNo`),
 ADD KEY `studentNo` (`studentNo`);
ALTER TABLE `paymentreminder`
 ADD KEY `invoiceNo` (`invoiceNo`);
ALTER TABLE `residencehall`
 ADD PRIMARY KEY (`hallNo`),
 ADD KEY `HMStaffNo` (`HMStaffNo`);
ALTER TABLE `student`
 ADD PRIMARY KEY (`studentNo`),
 ADD KEY `courseNo` (`courseNo`),
 ADD KEY `advisorNo` (`advisorNo`);
ALTER TABLE `studentflat`
 ADD PRIMARY KEY (`flatNo`);
ALTER TABLE `update_logs`
 ADD PRIMARY KEY (`logId`);
ALTER TABLE `accomstaff`
 MODIFY `staffNo` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `advisor`
 MODIFY `advisorNo` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `course`
 MODIFY `courseNo` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `flatroom`
 MODIFY `flatPlaceNo` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `hallroom`
 MODIFY `hallPlaceNo` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `invoice`
 MODIFY `invoiceNo` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `lease`
 MODIFY `leaseNo` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `nok`
 MODIFY `studentNo` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `residencehall`
 MODIFY `hallNo` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `student`
 MODIFY `studentNo` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `studentflat`
 MODIFY `flatNo` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `update_logs`
 MODIFY `logId` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `flatroom`
 ADD CONSTRAINT `flatroom_ibfk_1` FOREIGN KEY (`flatNo`) REFERENCES `studentflat` (`flatNo`);
ALTER TABLE `hallroom`
 ADD CONSTRAINT `hallroom_ibfk_1` FOREIGN KEY (`hallNo`) REFERENCES `residencehall` (`hallNo`);
ALTER TABLE `inspection`
 ADD CONSTRAINT `inspection_ibfk_1` FOREIGN KEY (`staffNo`) REFERENCES `accomstaff` (`staffNo`),
 ADD CONSTRAINT `inspection_ibfk_2` FOREIGN KEY (`flatNo`) REFERENCES `studentflat` (`flatNo`);
ALTER TABLE `invoice`
 ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`leaseNo`) REFERENCES `lease` (`leaseNo`);
ALTER TABLE `lease`
 ADD CONSTRAINT `lease_ibfk_1` FOREIGN KEY (`studentNo`) REFERENCES `student` (`studentNo`),
 ADD CONSTRAINT `lease_ibfk_2` FOREIGN KEY (`hallPlaceNo`) REFERENCES `hallroom` (`hallPlaceNo`),
 ADD CONSTRAINT `lease_ibfk_3` FOREIGN KEY (`flatPlaceNo`) REFERENCES `flatroom` (`flatPlaceNo`);
ALTER TABLE `nok`
 ADD CONSTRAINT `nok_ibfk_1` FOREIGN KEY (`studentNo`) REFERENCES `student` (`studentNo`);
ALTER TABLE `payment`
 ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`invoiceNo`) REFERENCES `invoice` (`invoiceNo`),
 ADD CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`studentNo`) REFERENCES `student` (`studentNo`);
ALTER TABLE `paymentreminder`
 ADD CONSTRAINT `paymentreminder_ibfk_1` FOREIGN KEY (`invoiceNo`) REFERENCES `invoice`
(`invoiceNo`);
ALTER TABLE `residencehall`
 ADD CONSTRAINT `residencehall_ibfk_1` FOREIGN KEY (`HMStaffNo`) REFERENCES `accomstaff`
(`staffNo`);
ALTER TABLE `student`
 ADD CONSTRAINT `student_ibfk_1` FOREIGN KEY (`courseNo`) REFERENCES `course` (`courseNo`),
 ADD CONSTRAINT `student_ibfk_2` FOREIGN KEY (`advisorNo`) REFERENCES `advisor` (`advisorNo`)