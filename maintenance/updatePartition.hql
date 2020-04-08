


DESCRIBE FORMATTED warehouse.FtSales PARTITION (`year`=2020,`month`=2)

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;

DROP TABLE IF EXISTS warehouse.FtSales_exchange;
CREATE TABLE warehouse.FtSales_exchange LIKE warehouse.FtSales;

INSERT INTO TABLE warehouse.FtSales_exchange PARTITION ( `year`=2020,`month`=2 )
SELECT 
 *
FROM warehouse.vw_FtSales
WHERE
        year = 2020
    AND
        month = 2;

ANALYZE TABLE warehouse.FtSales_exchange PARTITION (`year`=2020,`month`=2) COMPUTE STATISTICS FOR COLUMNS; 

ALTER TABLE warehouse.FtSales DROP PARTITION (`year`=2020,`month`=2);

ALTER TABLE warehouse.FtSales EXCHANGE PARTITION (`year`=2020,`month`=2) WITH TABLE warehouse.FtSales_exchange;