use utf8;
binmode(STDOUT, ":utf8");
#-------------------------------------------
# Name:Main.pl
#-------------------------------------------
use Mediator;
use Parts;

#ディレクターのインスタンス化
my $m=Parts_Director->new();

#自身のディレクションするパーツを作成する
$m->create_parts();

#数値の値を変える
$m->set_parts_value(1);

#文字の値を変える
$m->set_parts_value(abc);

