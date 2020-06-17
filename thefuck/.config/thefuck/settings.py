rules = [
        'aws_cli',
        'brew_cask_dependency',
        'brew_install',
        'brew_reinstall',
        'brew_link',
        'brew_uninstall',
        'brew_unknown_command',
        'brew_update_formula',
        'cargo',
        'cargo_no_command',
        'cat_dir',
        'cd_correction',
        'cd_mkdir',
        'cd_parent',
        'cp_create_destination',
        'docker_login',
        'docker_not_command',
        'docker_image_being_used_by_container',
        'dry',
        'fix_file',
        'git_add',
        'git_branch_delete',
        'git_branch_delete_checked_out',
        'git_branch_exists',
        'git_checkout',
        'git_diff_no_index',
        'git_diff_staged',
        'git_help_aliased',
        'git_merge',
        'git_not_command',
        'git_pull',
        'git_pull_uncommitted_changes',
        'git_push',
        'git_push_without_commits',
        'git_rebase_no_changes',
        'git_remote_delete',
        'git_rm_local_modifications',
        'git_rm_recursive',
        'git_push_force',
        'git_stash',
        'git_stash_pop',
        'git_tag_force',
        'git_two_dashes',
        'go_run',
        'go_unknown_command',
        'grep_arguments_order',
        'grep_recursive',
        'has_exists_script',
        'history',
        'ln_no_hard_link',
        'ln_s_order',
        'ls_all',
        'man_no_space',
        'missing_space_before_subcommand',
        'mkdir_p',
        'mvn_no_command',
        'mvn_unknown_lifecycle_phase',
        'no_command',
        'no_such_file',
        'port_already_in_use',
        'quotation_marks',
        'path_from_history',
        'remove_shell_prompt_literal',
        'rm_dir',
        'sed_unterminated_s',
        'sl_ls',
        'ssh_known_hosts',
        'sudo',
        'terraform_init',
        'touch',
        'tmux',
        'unknown_command',
        ]
exclude_rules = []
wait_command = 3
require_confirmation = True
no_colors = False
debug = False
priority = {}
history_limit = 2000
alter_history = True
wait_slow_command = 10
repeat = False
instant_mode = False
num_close_matches = 5
