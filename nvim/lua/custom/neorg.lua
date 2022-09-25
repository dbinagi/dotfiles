require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ['core.norg.journal'] = {
            config = {
                strategy = 'flat',
                journal_folder = '~/neorg/journal/',
            }
        },
        ['core.norg.dirman'] = {
            config = {
                workspaces = {
                    notes = '~/neorg/notes/',
                }
            }
        },
        ['core.gtd.base'] = {
            config = {
                workspace = 'notes'
            }
        },

    }
}
