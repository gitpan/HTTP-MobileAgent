use strict;

use strict;
use Test::More tests => 12;

BEGIN { use_ok 'HTTP::MobileAgent' }

my @Tests = (
    # ua, method_hash
    [ "Mozilla/3.0(DDIPOCKET;JRC/AH-J3001V,AH-J3002V/1.0/0100/c50)CNF/2.0",
      name => 'DDIPOCKET', vendor => 'JRC', model => 'AH-J3001V,AH-J3002V',
      model_version => '1.0', browser_version => '0100', cache_size => 50 ],
);

for (@Tests) {
    my($ua, %data) = @$_;
    my $agent = HTTP::MobileAgent->new($ua);
    isa_ok $agent, 'HTTP::MobileAgent';
    isa_ok $agent, 'HTTP::MobileAgent::AirHPhone';
    ok $agent->is_airh_phone;

    for my $key (keys %data) {
	is $agent->$key(), $data{$key}, "$key is $data{$key}";
    }
}

while (<DATA>) {
    next if /^#/;
    chomp;
    local $ENV{HTTP_USER_AGENT} = $_;
    my $agent = HTTP::MobileAgent->new;
    isa_ok $agent, 'HTTP::MobileAgent', "$_";
    ok $agent->is_airh_phone;
}

__END__
Mozilla/3.0(DDIPOCKET;JRC/AH-J3001V,AH-J3002V/1.0/0100/c50)CNF/2.0
