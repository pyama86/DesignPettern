use utf8;
#-------------------------------------------
# Name:LogProcessor.pm
#-------------------------------------------
package SEARCH::LogProcessor;
	use Moose;
	use MooseX::AttributeHelpers;
	use SEARCH::LogHandler;
		has 'handlers' => (
			metaclass	=>	'Collection::Array',
			is 		=>	'rw',
			isa		=>	'ArrayRef[SEARCH::LogHandler]',
			#自動でデリファレンスする
			auto_deref	=>	1,
			#undefだと最初のpushの際にエラーになるため、デフォルトで無名を入れておく
			default		=> 	sub { [] },
			#メタクラスを指定して、AttribteHelpersのprovidesでpushイベントを追加する
			provides	=>	{
				push	=>	'add_handler'
			}
		);
		__PACKAGE__->meta->make_immutable();
	no Moose;

	#リクエストを処理するメソッド
	sub search_request {
		my ($self,$request) = @_;
		
		for my $handler ($self->handlers){
			#処理が実行されるまでハンドラーを順次処理する
			last if($handler->search_request($request));
		}
		#例外が想定されるのであれば、終了フラグを変数化しておいて
		#if(!defined($flg){
		#	die "request error:$!
		#}
		#と言った具合に書くといい
	}
1;
