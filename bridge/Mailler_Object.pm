use utf8;
#---------------------------------------
# Name:Mailler_Object.pm
#---------------------------------------
package Mailler_Object;
	use Moose;
		has 'receiver' =>(
			is		=>	'rw',
			does		=>	'Receive_Role', #実装メソッドの制約
			required	=>	1,
			#handlesで定義したメソッドを定義できる
			handles		=> [qw(connect getuidl getmsg disconnect)]
		);

		__PACKAGE__->meta->make_immutable();
	no Moose;
	1;

