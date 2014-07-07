use utf8;
#-------------------------------------------
# Name:Parts.pm
#-------------------------------------------
#パーツの抽象クラス
package Parts;

	use Mediator;
	use Moose::Role;
		#ディレクターの参照変数
		has 'director' => (
			is		=>	'rw',
			isa		=>	'Mediator',
			required	=>	'1'
		);
		#自身の名前格納変数
		has 'name' => (
			is	=>	'rw',
			isa	=>	'Str',
		);
		#自身の値格納変数
		has 'value' => (
			is	=>	'rw'
		);
	no Moose::Role;

	#オブジェクトの値が変わった際にディレクターに通知するメソッド
	sub change {
		my $self = shift;
		$self->director->parts_change($self);
	};
	#値の設定
	sub setvalue {
		my $self = shift;
		$self->value(shift);
		$self->change();
	}
#文字列を扱うクラス
package Parts::Parts_String;
	use Moose;
		with 'Parts';
		has '+value' => (
			isa	=>	'Str'
		);
		__PACKAGE__->meta->make_immutable();
	no Moose;

#数値を扱うクラス
package Parts::Parts_Int;
        use Moose;
                with 'Parts';
                has '+value' => (
                        isa     =>      'Int'
                );
                __PACKAGE__->meta->make_immutable();
        no Moose;
1;
