create or replace function isAvailable(doctorschedule text, slotday INT)
returns BOOLEAN AS
$$
declare
    slotdaytext text;
begin
    slotdaytext := slotday::text;
    return doctorschedule like '%' || slotdaytext || '%';
end;
$$
language plpgsql;



create or replace function generateslot(slotstarttime TIME, slottime INT)
returns time as
$$
begin
   
    return (slotstarttime::time + (slottime || ' minutes')::interval)::TIME;
end;
$$
language plpgsql;




create or replace function noofslots(totaltime TIME, avgtime INT)
RETURNS INT AS
$$
DECLARE
    totalseconds INT;
    avgseconds INT;
    numberofslots INT;
BEGIN
    totalseconds := EXTRACT(EPOCH FROM totaltime)::INT;
    avgseconds := avgtime * 60; 
    numberofslots := totalseconds / avgseconds;

    RETURN numberofslots;
END;
$$
LANGUAGE plpgsql;


create or replace Procedure generateslots(doctid int) 
as 
$$
declare
    currentdate date;
    slotrange int;
    dayvalue int;
    doctorschedule text;
    starttime time;
    endtime time;
    avgtime int;
    totaltime time;
    totalslots int;
	slottime time;
BEGIN
	
    currentdate := NOW()::date;
    select range from doctorrange where doctorid = doctid into slotrange;
    for i in 1..slotrange loop
        if not exists (
            select slotdate
            from ajayappointmentslots
            where slotdoctorid = doctid
            and slotdate = currentdate
        ) then
            select extract(DOW from currentdate::DATE) into dayvalue;
            select ajayschedule.doctorschedule into doctorschedule
    		from ajayschedule
    		where doctorid = doctid;

            if isAvailable(doctorschedule, dayvalue) then 
                select doctoravailablefrom into starttime from ajayschedule where doctorid = doctid;
                select doctoravailableto into endtime from ajayschedule where doctorid = doctid;
                select doctoravailableslot into avgtime from ajayschedule where doctorid = doctid;
				starttime := starttime::TIME;
    			endtime := endtime::TIME;
                select doctoravailableto-doctoravailablefrom into totaltime from ajayschedule where doctorid = doctid;
				select noofslots(totaltime, avgtime) into totalslots;
                for j IN 1..totalslots loop
                    SELECT generateslot(starttime, avgtime) INTO slottime;
                    insert into ajayappointmentslots(slotdoctorid, slotdate, slotfrom, slotto, slotstatus)
                    VALUES (doctid, currentdate, starttime,slottime , 'available');
					starttime := generateslot(starttime, avgtime);
                END LOOP;
            END IF;
        END IF;
        currentdate := currentdate + 1;
    END LOOP;
    
END;
$$
LANGUAGE plpgsql;

create or replace function generateappointmentslots() returns trigger AS $$
   begin
      call generateslots(new.doctorid);
      return new;
   end;
$$ language plpgsql;
drop trigger 
CREATE TRIGGER slotgenerationtrigger
AFTER INSERT ON ajayschedule
FOR EACH ROW
EXECUTE FUNCTION generateappointmentslots();

alter table ajayschedule enable trigger slotgenerationtrigger;

