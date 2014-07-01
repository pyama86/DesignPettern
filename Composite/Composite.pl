use utf8;
#-------------------------------------------
# Name:Composite.pl
#-------------------------------------------
use strict;
use warnings;
use Composition::DirectoryFile;

#ファイルAの作成
my $fileA=File->new( target=>'FileA');

#ディレクトリAの作成
my $dirA=Directory->new(target=>'DirA');

#ディレクトリAの中にファイルBの作成
$dirA->add_object(File->new( target=>'FileB'));

#ディレクトリBの作成
my $dirB=Directory->new(target=>'DirB');

#ディレクトリBの中にディレクトリAを格納
$dirB->add_object($dirA);

#オブジェクトリストの印字
print " ------- get list -------\n\n";
$fileA->list;
$dirB->list;

#オブジェクトリストの削除
print "\n------ remove list ------\n\n";
$fileA->remove();
$dirB->remove();
print "\n";
