use utf8;
binmode(STDOUT, ":utf8");
#--------------------------------------
# Name:LogHandler.pm
#--------------------------------------

#
# 抽象クラス相当のロール
#
package SEARCH::LogHandler;
	use Moose::Role;
		requires 'search_request';
	no Moose::Role;

#
# 以降各ハンドルを処理するクラス
#
package SEARCH::LogHandler::Incoming;
        use Moose;
                with 'SEARCH::LogHandler';
                __PACKAGE__->meta->make_immutable();
        no Moose;

        sub search_request {
                my ($class,$request) = @_;
                return () unless $request->{type} eq 'incm';
        
                print "検索タイプは$request->{type}で日付は$request->{date}です\n";
        }
package SEARCH::LogHandler::Virus;
        use Moose;
                with 'SEARCH::LogHandler';
                __PACKAGE__->meta->make_immutable();
        no Moose;

        sub search_request {
                my ($class,$request) = @_;
                return () unless $request->{type} eq 'virus';

                print "検索タイプは$request->{type}で日付は$request->{date}です\n";
        }
package SEARCH::LogHandler::Ogo;
        use Moose;
                with 'SEARCH::LogHandler';
                __PACKAGE__->meta->make_immutable();
        no Moose;

        sub search_request {
                my ($class,$request) = @_;
                return () unless $request->{type} eq 'ogo';

                print "検索タイプは$request->{type}で日付は$request->{date}です\n";
        }
1;
