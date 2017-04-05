#!/usr/bin/perl
#
# Usage:
#  cat /export/obs/system/SystemLog/2009-10-19.log | perl obslog.pl
#
# Converts Java timestamp to humanly readable
#

use Time::localtime;

@wday=('Sun','Mon','Tue','Wed','Thu','Fri','Sat');
@month=('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');

sub epochToDate {
   my ($epoch) = @_;

   $tm = localtime($epoch/1000);
   return(sprintf("[%02d/%s/%4d %02d:%02d:%02d]", $tm->mday, $month[$tm->mon], $tm->year+1900,
                                                  $tm->hour, $tm->min, $tm->sec));
}

while(<STDIN>)
{
   ($date, $rest) = /^(\d+)\,(.*)/;
   printf("%s%s\n", epochToDate($date), $rest);
}
