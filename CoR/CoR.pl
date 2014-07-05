#---------------------------------------------
# Name:CoR.pl
#---------------------------------------------
use utf8;
use strict;
use warnings;
use lib ('./');
use SEARCH::LogHandler;


my $handlers=SEARCH::LogHandler::Incoming->new(
	 successor => SEARCH::LogHandler::Virus->new(
		successor => SEARCH::LogHandler::Ogo->new()
	)
);

#処理依頼する
$handlers->search_request({type => 'ogo',date => '0101'});
$handlers->search_request({type => 'incoming',date => '0401'});
