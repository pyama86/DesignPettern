use utf8;
#--------------------------------------------
# Name:DirFile.pm
#--------------------------------------------
package DirectoryFile;
	use Moose::Role;
		requires qw(list remove);
		has 'target' => (
			is		=>	'rw',
			required	=>	1,
		);
	no Moose::Role;

package File;
	my $self = shift;
	use Moose;
		with 'DirectoryFile';
		__PACKAGE__->meta->make_immutable();
	no Moose;
	
	sub list {
		my $self = shift;
		print "/" . $self->target() . "\n";
	}
	sub remove {
		my $self = shift;
		print "/" , $self->target() , " at removed\n";
	}
package Directory;
	use Moose;
        use MooseX::AttributeHelpers;
		with 'DirectoryFile';
                
		#再帰的にオブジェクトを持てるようにする
		has 'DirFileObject' => (
                        is              =>      'rw',
                        isa             =>      'ArrayRef[DirectoryFile]',
                        metaclass       =>      'Collection::Array',
                        auto_deref      =>      1,  
                        provides        =>      {   
                                push    =>      'add_object'
                        },  
                        default         =>      sub { [] },    
                );
		__PACKAGE__->meta->make_immutable();

	no Moose;

	sub list {
		my ($self,$parrent) = @_;
		
		#フォルダ階層文字の結合
		$parrent .= "/" . $self->target();

		#自分自身の印字
		print $parrent , "\n";	
		
		#格納されているオブジェクトを全て取得する
		for my $obj($self->DirFileObject()){
			#ファイルじゃなければ再帰処理
			unless($obj->isa("File")){
				$obj->list($parrent);
			}else{
				print $parrent ,  "/" , $obj->target() , "\n";
			}
		}
	};
	sub remove{
		my ($self,$parrent) = @_;
		
		#フォルダ階層文字の結合
		$parrent .= "/" . $self->target();

		#格納されているオブジェクトを全て取得する
		for my $obj($self->DirFileObject()){
			#ファイルじゃなければ再帰処理
			unless($obj->isa("File")){
				$obj->remove($parrent);
			}else{
				print $parrent ,  "/" , $obj->target() , " at removed\n";
			}
		}
		#自分自身の印字
		print $parrent , " at removed\n";	
	};
