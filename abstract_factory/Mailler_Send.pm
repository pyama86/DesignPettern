use utf8;
#**************************************
# Name:Mailler_Send.pm
#**************************************

#--------------------------------------
# 送信の抽象クラス(ロール)
#--------------------------------------
package Send_Abstract;
	use Moose::Role;
		requires qw(connect send disconnect);
	no Moose::Role;


#--------------------------------------
# 送信の具象クラス
#--------------------------------------
package Send_Concrete_Smtp;
	use Net::SMTP;
	use Jcode;
	use Moose;
		with 'Send_Abstract';
		has 'server' => (
			is      =>      'rw',
			isa     =>      'Str',
			required        =>      1
		);
		has 'socket' => (
			is      =>      'rw',
			isa     =>      'Net::SMTP'
		);


		__PACKAGE__->meta->make_immutable();
	no Moose;

	sub connect{
		my $self=shift;
		eval{
			$self->socket(Net::SMTP->new($self->server, Port => 25,Timeout=>10,Debug=>0)) or die;
		};
		if($@){
			return(-1);
		}
	}
	sub send{
		my ($self,$from,$to,$subject,$body) = @_;
		my $header;
		my $content;	
		#ヘッダを組み立てる
		$header = "From: " . jcode("$from")->mime_encode . "\n";
		$header .= "To: " . jcode("$to")->mime_encode . "\n";
		$header .= "Subject: " . jcode($subject)->mime_encode . "\n";
		$header .= "MIME-Version: 1.0\n";
		$header .= "Content-type: text/plain; charset=ISO-2022-JP\n";
		$header .= "Content-Transfer-Encoding: 7bit\n\n";
		
		#ボディーを変換する
		$content=jcode($body)->jis;
		#送信する
		eval{
			$self->socket->mail($from);
			$self->socket->to($to);
			$self->socket->data();
			$self->socket->datasend($header);
			$self->socket->datasend($content);
			$self->dataend();
		}
	}
	sub disconnect{
		shift->socket->quit;
	}
1;
