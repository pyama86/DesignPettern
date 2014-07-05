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
		has 'successor' => (
			is		=>	'rw',
			isa		=>	'SEARCH::LogHandler'
		);
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
                my ($self,$request) = @_;
                (my $cname =__PACKAGE__)=~ s/.*:://g;

		if($request->{type} =~ /$cname/i){
                	print "検索タイプは$request->{type}で日付は$request->{date}です\n";
		}else{
			$self->successor->search_request($request);
        	}
	}

package SEARCH::LogHandler::Virus;
        use Moose;
                with 'SEARCH::LogHandler';
                __PACKAGE__->meta->make_immutable();
        no Moose;

        sub search_request {
                my ($self,$request) = @_;
                (my $cname =__PACKAGE__)=~ s/.*:://g;

		if($request->{type} =~ /$cname/i){
                	print "検索タイプは$request->{type}で日付は$request->{date}です\n";
		}else{
			$self->successor->search_request($request);
        	}
	}
package SEARCH::LogHandler::Ogo;
        use Moose;
                with 'SEARCH::LogHandler';
                __PACKAGE__->meta->make_immutable();
        no Moose;

        sub search_request {
                my ($self,$request) = @_;
                (my $cname =__PACKAGE__)=~ s/.*:://g;

		if($request->{type} =~ /$cname/i){
                	print "検索タイプは$request->{type}で日付は$request->{date}です\n";
		}else{
			$self->successor->search_request($request);
        	}
	}
1;
