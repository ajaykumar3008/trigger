
create table ajayschedule as 
select * from ajayschedule;
select * from appointmentsslotcalendar;
create table ajayappointmentslots as 
select * from appointmentsslotcalendar;
DELETE FROM ajayschedule;

insert into ajayschedule values(1,2,'0123456','09:00:00','12:00:00',15);

CREATE TRIGGER slotgenerationtrigger
AFTER INSERT ON ajayschedule
FOR EACH ROW
EXECUTE FUNCTION generateslots(NEW.doctorid);



CREATE OR REPLACE FUNCTION slotduration(startdate TIME, slottime INT)
RETURNS TIME AS
$$
DECLARE
    newtime TIME;
BEGIN
    newtime := startdate + (slottime || ' minutes')::INTERVAL;
    RETURN newtime;
END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION isAvailable(doctorschedule text, slotday INT)
RETURNS TIME AS
$$
DECLARE
    slotdaytext text;
BEGIN
    slotdaytext:=slotday::text;
    return doctorschedule like '%' || slotdaytext || '%';
    
END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION generateslot(slotstarttime TIME, slottime INT)
RETURNS TIME AS
$$
BEGIN
    RETURN slotstarttime + (slottime || ' minutes')::INTERVAL;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION noofslot(totaltime TIME, avgtime INT)
RETURNS INT AS
$$
DECLARE
    totalseconds INT;
    avgseconds INT;
    numberofslots INT;
BEGIN

    totalseconds := EXTRACT(EPOCH FROM totaltime);
    avgseconds := avgtime * 60; 
    numberofslots := totalseconds / avgseconds;

    RETURN numberofslots::INT;
END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION generateslots(doctid integer) 
RETURNS void AS
$$
DECLARE
    currentdate date;
    slotrange int;
    dayvalue int;
     doctorschedule text;
	starttime time;
	endtime time;
    avgtime time;
    totaltime time;
BEGIN
    	currentdate := NOW()::date;
	select range from doctorrange where doctorid=doctid into slotrange;
    FOR i IN 1..slotrange LOOP
        
        IF NOT EXISTS (
            SELECT slotdate
            FROM ajayappointmentslots
            WHERE slotdoctorid = generateslots.doctid
            AND slotdate = currentdate
        ) THEN
		SELECT extract(dow FROM currentdate::date) INTO dayvalue;
   		SELECT doctorschedule INTO doctorschedule
    		FROM ajayschedule
    		WHERE doctorid = doctid; 

			IF isAvailable(doctorschedule,dayvalue)
			THEN 
			select doctoravailablefrom from ajayschedule where doctorid=doctid into starttime;
			select doctoravailableto from ajayschedule where doctorid=doctid into endtime;
			select doctoravailableslot from ajayschedule where doctorid=doctid into avgtime;
			totaltime := (timestamp '1970-01-01' + (timestamp 'starttime' - timestamp 'endtime'))::TIME;


				FOR i in 1..noofslots(totaltime,avgtime) LOOP
					select generateslot(starttime,avgtime) as slotto;
					insert into ajayappointmentslots(slotdoctorid,slotdate,slotfrom,slotto,slotstatus) values(doctid,currentdate,starttime,slotto,'available');
            			starttime:=slotto;
				END LOOP
            END IF;
        END IF;

        
        currentdate := currentdate + 1;
    END LOOP;
END;
$$
LANGUAGE plpgsql;



DROP FUNCTION generateslots;

CREATE OR REPLACE FUNCTION generateslots() 
RETURNS TRIGGER AS 
$slotgenerationtrigger$
DECLARE
    currentdate DATE;
    slotrange INT;
    dayvalue INT;
    doctorschedule TEXT;
    starttime TIME;
    endtime TIME;
    avgtime TIME;
    totaltime INTERVAL;
    doctid int;
BEGIN
	doctid := NEW.doctorid;
    currentdate := NOW()::DATE;
    SELECT range FROM doctorrange WHERE doctorid = doctid INTO slotrange;
    FOR i IN 1..slotrange LOOP
        IF NOT EXISTS (
            SELECT slotdate
            FROM ajayappointmentslots
            WHERE slotdoctorid = doctid
            AND slotdate = currentdate
        ) THEN
            SELECT EXTRACT(DOW FROM currentdate::DATE) INTO dayvalue;
            SELECT ajayschedule.doctorschedule INTO doctorschedule
    FROM ajayschedule
    WHERE doctorid = doctid;

            IF isAvailable(doctorschedule, dayvalue) THEN 
                SELECT doctoravailablefrom INTO starttime FROM ajayschedule WHERE doctorid = doctid;
                SELECT doctoravailableto INTO endtime FROM ajayschedule WHERE doctorid = doctid;
                SELECT doctoravailableslot INTO avgtime FROM ajayschedule WHERE doctorid = doctid;
                totaltime := (timestamp '1970-01-01' + (starttime - endtime));

                FOR j IN 1..noofslots(totaltime, avgtime) LOOP
                    starttime := generateslot(starttime, avgtime);
                    INSERT INTO ajayappointmentslots(slotdoctorid, slotdate, slotfrom, slotto, slotstatus)
                    VALUES (doctid, currentdate, starttime, generateslot(starttime, avgtime), 'available');
                END LOOP;
            END IF;
        END IF;
        currentdate := currentdate + 1;
    END LOOP;
    RETURN NEW; -- Return NEW to indicate success
END;
$slotgenerationtrigger$
LANGUAGE plpgsql;

-- Create the trigger
CREATE TRIGGER slotgenerationtrigger
AFTER INSERT ON ajayschedule
FOR EACH ROW
EXECUTE FUNCTION generateslots();

alter table ajayschedule enable trigger slotgenerationtrigger;


