use Test::Perl::Critic(-exclude => [
											   'RequireExtendedFormatting',
												'ProhibitPackageVars',
												'ProhibitComplexRegexes',
												'ProhibitAugmentedAssignmentInDeclaration',
											  ],
							  -severity => 3);
all_critic_ok();
