#---------------------------------------------
# Name:CoR.pl
#---------------------------------------------
use utf8;
use strict;
use warnings;
use lib ('./');
use SEARCH::LogProcessor;
use SEARCH::LogHandler;

#プロセッサーのインスタンス化
my $p = SEARCH::LogProcessor->new();

#ハンドラーを追加する
$p->add_handler(SEARCH::LogHandler::Incoming->new());
$p->add_handler(SEARCH::LogHandler::Virus->new());
$p->add_handler(SEARCH::LogHandler::Ogo->new());

#処理依頼する
$p->search_request({type => 'ogo',date => '0101'});
