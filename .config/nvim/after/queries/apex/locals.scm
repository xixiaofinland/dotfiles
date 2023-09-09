; locals.scm

(class_declaration) @scope
(method_declaration) @scope
(constructor_declaration) @scope
(enhanced_for_statement) @scope
(enum_declaration) @scope



; (method_declaration) @local.scope
; (do_statement) @local.scope
;
; (method_declaration
;   (formal_parameters (formal_parameter (identifier) @local.definition)))
;
; (variable_declarator . (identifier) @local.definition)
;
; (enum_declaration
;   name: (identifier) @local.definition)
; (enum_constant
;         name: (identifier) @local.definition)
;
; (identifier) @local.reference
