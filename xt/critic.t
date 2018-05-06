use Test::Perl::Critic(-exclude => [
												'RequireFinalReturn',
											   'ProhibitUnusedPrivateSubroutines',
											   'RequireExtendedFormatting',
											   'ProhibitExcessComplexity',
												'ProhibitPackageVars',
												'ProhibitComplexRegexes',
												'ProhibitAugmentedAssignmentInDeclaration',
											  ],
							  -severity => 3);
all_critic_ok();
