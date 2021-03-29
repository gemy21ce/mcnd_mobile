# API URL

- https://mcnd.ie/wp-json/dpt/v1/prayertime?filter=today

### Parameters

- filter=today: will Return prayer time for today
- filter=month: will Return prayer time for the month
- filter=year: will Return prayer time whole year
- filter=ramadan: will Return prayer time for Ramadaan
- filter=iqamah: will Return Iqamah time for today
- filter=tomorrow_fajr: will Return next day Fajr prayer time
- filter=iqamah_changes: will Return the upcoming Iqamah time changes for tomorrow

#### sample output 

``` {
       "d_date": "2020-05-17",
       "fajr_begins": "02:48:00",
       "fajr_jamah": "03:48:00",
       "sunrise": "05:05:00",
       "zuhr_begins": "12:57:00",
       "zuhr_jamah": "14:27:00",
       "asr_mithl_1": "17:10:00",
       "asr_mithl_2": "17:10:00",
       "asr_jamah": "17:55:00",
       "maghrib_begins": "20:49:00",
       "maghrib_jamah": "20:54:00",
       "isha_begins": "23:07:00",
       "isha_jamah": "23:22:00",
       "is_ramadan": "0",
       "hijri_date": "0",
       "jamah_changes": {
         "fajr_jamah": "03:45:00",
         "asr_jamah": "17:56:00",
         "maghrib_jamah": "20:56:00",
         "isha_jamah": "23:25:00"
       },
       "hijri_date_convert": "Ramadan 24, 1441"
     }``` 