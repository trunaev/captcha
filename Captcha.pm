package Captcha;

use 5.012;
use warnings;

use constant CHARS  => join ('','A'..'Z',0,2..9);
use constant WIDTH 	=> '300';
use constant HEIGHT => '125';

BEGIN {
	srand(time());	
}

use Image::Magick;

sub new {
	my $class = shift;
	my $self = {};
	return bless $self, $class;
}

sub generate {
	my $self = shift;
	my $file = shift;

	my $str = $self->random_str;


	my $pointsize = 70;

	my $image = new Image::Magick;

	$image->Set(size => WIDTH().'x'.HEIGHT());
	$image->ReadImage('xc:white');

	$image->Set(
		type        => 'TrueColor',
		antialias   =>  'True',
		fill        =>  'black',
		pointsize   =>  $pointsize,
	);

	$image->Draw(primitive => 'text', points =>  '10,85', text =>  $str);

	#$image->Extent(geometry => '420x240');

	#$image->Roll(x =>  101+int(rand(4)));

	$image->Swirl(degrees =>  int(rand(14))+37);

	#$image->Extent(geometry =>  '420x240');
	#$image->Roll(x =>  42-int(rand(42)));
	#$image->Swirl(degrees =>  int(rand(42))+20);
	#$image->Crop('300x100+100+17');
	#$image->Resize('210x125');
	
	my @p = '';
	for (1..42) {
		$image->Draw(primitive=>'line', points => int(rand(WIDTH())).','.int(rand(HEIGHT())).' '.int(rand(WIDTH())).','.int(rand(HEIGHT())),stroke=>'black');
	}

	open(IMAGE,'>',$file) or die $!;
	$image->Write(file=>\*IMAGE, filename=>$file);
	close(IMAGE);
	
	return;
}

sub random_str {
	my $self = shift;

	state $l = length CHARS();
	
	my $str = '';
	for(1..6) {
		$str .= substr(CHARS(), rand($l), 1);
	}
	return $str;
}

1;

1;
