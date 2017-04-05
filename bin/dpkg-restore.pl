#!/usr/bin/perl -w
#

my $docsdir = "/usr/share/doc/";
my $listsdir = "/var/lib/apt/lists/";

my (@packages, @lists);

# Get package names
print "Reading all installed packages.\n";
opendir(DOCSDIR, "$docsdir") or die "Couldn't open $docsdir : $!";
while (defined(my $packagename = readdir(DOCSDIR))) {
        push(@packages, $packagename) if (!($packagename =~ m/([A-Z]|^debian$|\.+)/));
        print ".";
}
print "\n";
closedir(DOCSDIR);
print "Reading complete.\n";
my $p_count = $#packages + 1;
print "There was $p_count packages found.\n";
undef $p_count;

# Get package indexes
opendir(LISTSDIR, "$listsdir") or die "Couldn't open $listsdir : $!";
while (defined(my $listname = readdir(LISTSDIR))) {
        push(@lists, $listname) if ($listname =~ m/Packages/);
}
closedir(LISTSDIR);

# Searching information and make new dpkg status file.
open(my $statusfile, '>', 'status');
foreach my $package (@packages) {
        my %information;
        foreach my $list (@lists) {
                my $filepath = join('/', $listsdir, $list);
                open(my $listfile, '<', $filepath);
                my $write = 0;
                my $multiline = 0;
                while ( defined($line = readline($listfile)) ) {
                        if (grep(/^Package: $package$/, $line)) {
                                print "Package $package found in list $list.\n";
                                $write = 1;
                        }
                        if ( ($write) && (!$multiline) ) {
                                if ( $line =~ m/^Tag/ ) {
                                        $multiline = 1;
                                } else {
                                        my @data = split(/:\s/, $line);
                                        $information{"$data[0]"} = $data[1];
                                }
                        }
                        if ( ($write) && ($multiline) ) {
                                if ( $line =~ m/^Tag/ ) {
                                        my @data = split(/:\s/, $line);
                                        $information{"$data[0]"} = $data[1];
                                } elsif ( $line =~ m/^\s/ ) {
                                        $information{"Tag"} = join('', $information{"Tag"}, $line);
                                } else {
                                        $multiple = 0;
                                }
                        }
                        $write = 0 if ($line =~ m/^$/);
                }
                close($listfile);
        }
        print { $statusfile } "Package: $information{'Package'}" if (defined($information{"Package"}));
        print { $statusfile } "Status: install ok installed\n" if (defined($information{"Package"}));
        print { $statusfile } "Priority: $information{'Priority'}" if (defined($information{"Priority"}));
        print { $statusfile } "Section: $information{'Section'}" if (defined($information{"Section"}));
        print { $statusfile } "Installed-Size: $information{'Installed-Size'}" if (defined($information{"Installed-Size"}));
        print { $statusfile } "Maintainer: $information{'Maintainer'}" if (defined($information{"Maintainer"}));
        print { $statusfile } "Architecture: $information{'Architecture'}" if (defined($information{"Architecture"}));
        print { $statusfile } "Source: $information{'Source'}" if (defined($information{"Source"}));
        print { $statusfile } "Version: $information{'Version'}" if (defined($information{"Version"}));
        print { $statusfile } "Depends: $information{'Depends'}" if (defined($information{"Depends"}));
        print { $statusfile } "Description-md5: $information{'Description-md5'}" if (defined($information{"Description-md5"}));
        print { $statusfile } "Homepage: $information{'Homepage'}" if (defined($information{"Homepage"}));
        print { $statusfile } "Multi-Arch: $information{'Multi-Arch'}" if (defined($information{"Multi-Arch"}));
        print { $statusfile } "\n" if (defined($information{"Package"}));
}
close($statusfile);
