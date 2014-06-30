use utf8;

#**************************************
# Name:Mailler_Receive.pm
#**************************************

#--------------------------------------
# 受信の抽象クラス(ロール)
#--------------------------------------
package Receive_Abstract;
	use Moose::Role;
		has 'server' => (
			is	=>	'rw',
			isa	=>	'Str',
			required	=>	1
		);
		has 'mailaddress' => (
			is	=>	'rw',
			isa	=>	'Str',
			required	=>	1
		);
		has 'password' => (
			is	=>	'rw',
			isa	=>	'Str',
			required	=>	1
		);
		has 'socket' => (
			is	=>	'rw',
		);
		requires qw(connect getuidl getmsg disconnect);
	no Moose::Role;


#---------------------------------------
#POPの具象クラス
#---------------------------------------
package Receive_Concrete_Pop;
	use Net::POP3;
	use Moose;
		#ロールによって実装メソッドの制約
		with 'Receive_Abstract';

		has '+socket' => (
			isa	=>	'Net::POP3'
		);
		__PACKAGE__->meta->make_immutable;

	no Moose;

	sub connect {
		my $self=shift;
		eval{
			$self->socket(Net::POP3->new($self->server(), Port =>110)) or die;
			$self->socket->login($self->mailaddress, $self->password) or die
		};
		if($@){
			return(-1);
		}
	}
	sub getuidl {
		my %mlist; 
		eval{
			%mlist=%{shift->socket->uidl};
		};
		if($@){
			return(-1);
		}
		return %mlist;
	}
	sub getmsg {
		my ($self,$msgid)=@_;
		my $msg;
		my %mlist;

		eval{
			%mlist=%{shift->socket->uidl};
			
			for my $key(keys %mlist){
				if($msgid eq $mlist{$key}){
					$msg=$self->socket->get($key);
					last;
				}
			}
		};
		if($@){
			return(-1);
		}
		return @$msg;
	}
	sub disconnect {
		shift->socket->quit;
	}

#---------------------------------------
#IMAPの具象クラス
#---------------------------------------
package Receive_Concrete_Imap;
	use Mail::IMAPClient;
	use Moose;

		#ロールによって実装メソッドの制約
		with 'Receive_Abstract';

		has '+socket' => (
			isa	=>	'Mail::IMAPClient'
		);
		__PACKAGE__->meta->make_immutable;
	no Moose;

	sub connect {
		my $self=shift;
		eval{
			$self->socket(Mail::IMAPClient->new(
				Server          => $self->server,
				User            => $self->mailaddress,
				Password        => $self->password,
				Port            => 143,
				Ssl             => 0,
				Authmechanism   => 'PLAIN' ,
			)) or die;
			#受信ボックスを選択
			$self->socket->select('inbox');
		};
		if($@){
			return(-1);
		}
	}
	sub getuidl { 
		my @mlist;
		my %h;
		my $i=0;
		eval{
			@mlist=shift->socket->search("ALL");
		};
		if($@){
			return(-1);
		}
		for my $val(@mlist){
			$h{$i}=$val;
			$i++;
		}
		return %h;
	}
	sub getmsg {
		my ($self,$msgid)=@_;
		my $msg;
		eval{
			$msg=$self->socket->message_string($msgid);
		};
		if($@){
			return(-1);
		}
		return $msg;
	}
	sub disconnect {
		shift->socket->disconnect;
	}
1;
