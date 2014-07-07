use utf8;
#----------------------------------------------
# Name:Mediator.pm
#----------------------------------------------

# Mediaterの抽象クラス
package Mediator;
	use Moose::Role;
		requires 'parts_change';
	no Moose::Role;

# Mediaterの具象クラス
package Parts_Director;
	use Parts;
	use Moose;
		with 'Mediator';

		#パーツ格納用変数
		has 'parts_int' => (
			is	=>	'rw',
			isa	=>	'Parts'
		);
		has 'parts_str' => (
			is	=>	'rw',
			isa	=>	'Parts'
		);
		__PACKAGE__->meta->make_immutable();
	no Moose;

	#パーツの作成
	#テストコード実行のため便宜上実装
	sub create_parts {
		my $self = shift;
		$self->parts_str(Parts::Parts_String->new(director=>$self,name => 'strman',value => 'test')) unless $self->parts_str;
		$self->parts_int(Parts::Parts_Int->new(director=>$self,name => 'intman',value => '123')) unless $self->parts_int;
	}


	#パーツのセッター
	#テストコード実行のため便宜上実装
	sub set_parts_value {
		my ($self,$value) = @_;
		if($value =~ /[^0-9]/){
			$self->parts_str->setvalue($value);
		}else{
			$self->parts_int->setvalue($value);
		}
	}

	#パーツの値が変わった際に子オブジェクトから呼び出されるメソッド
	sub parts_change {
		my ($self,$parts)=@_;
		print $parts->name(),"の値が変更されました。\n";
		print "気になる値は、",$parts->value,"です\n";
	};
1;
