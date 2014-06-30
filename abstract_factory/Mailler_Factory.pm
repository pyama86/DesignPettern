use utf8;
#**************************************
# Name:Mailler_Factory.pm
#**************************************

#--------------------------------------
# 工場の抽象クラス(ロール)
#--------------------------------------
package Mailler_Abstract;
	use Moose::Role;
		requires qw(create_receive create_send);
	no Moose::Role;

#--------------------------------------
# 工場の具象クラス
#--------------------------------------
package Concreate_Factory;
	use lib './';
	use Mailler_Receive;
	use Mailler_Send;

	use Moose;
		#ロールで実装するメソッドに制約を与える
		with 'Mailler_Abstract';

		#接続タイプはPOPかIMAP
		has 'type' => (
			is	=>	'rw',
			isa	=>	'Str',
			default =>	'pop'
		);

		__PACKAGE__->meta->make_immutable;
	no Moose;

	#受信部品の作成
	sub create_receive{
		my ($self,$server,$mailaddress,$password) = @_;

		if($self->type() eq 'pop'){
			return(Receive_Concrete_Pop->new(server => $server, mailaddress => $mailaddress, password => $password));
		}else{
			return(Receive_Concrete_Imap->new(server => $server, mailaddress => $mailaddress, password => $password));
		}

	}
	
	#送信部品の作成
	sub create_send{
		my ($self,$server) = @_;
		return(Send_Concrete_Smtp->new( server => $server ));
	}
1;
