{ config, lib, ... }:

with lib;

let
  cfg = config.programs.plasma;

  # Widget types
  widgetType = lib.types.submodule {
    options = {
      plugin = lib.mkOption {
        type = lib.types.str;
        example = "org.kde.plasma.kickoff";
        description = "The name of the widget to add.";
      };
      dialog = lib.types.submodule {
        options = {
          height = lib.types.nullOr lib.mkOption {
            type = lib.types.int;
            default = 400;
            description = "The height of the dialog box.";
          };
          width = lib.mkOption {
            type = lib.types.nullOr lib.types.int;
            default = null;
            example = 600;
            description = "The width of the dialog box.";
          };
        };
      };
      popup = lib.types.submodule {
        options = {
          height = lib.types.nullOr lib.mkOption {
            type = lib.types.int;
            default = 400;
            description = "The height of the dialog box.";
          };
          width = lib.mkOption {
            type = lib.types.nullOr lib.types.int;
            default = null;
            example = 600;
            description = "The width of the dialog box.";
          };
        };
      };
      widgets = lib.mkOption {
        type = with lib.types;  nullOr listOf (either str widgetType);
        default = [
        
        ];
        example = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.marginsseperator"
          "org.kde.plasma.digitalclock"
        ];
        description = ''
          The widgets to use in the panel. To get the names, it may be useful
          to look in the share/plasma/plasmoids folder of the nix-package the
          widget/plasmoid is from. Some packages which include some
          widgets/plasmoids are for example plasma-desktop and
          plasma-workspace.
        '';
      };
      extraSettings = lib.mkOption {
        type = lib.types.attr;
        default = { };
        description = ''
          Extra lines to add to the layout.js. See
          https://develop.kde.org/docs/plasma/scripting/ for inspiration.
        '';
      };
    };
  };
  containmentType = {
    options = {
      formfactor = lib.mkOption {
        type = lib.types.nullOr (lib.types.enum [ "planar" "mediacenter" "horizontal" "vertical" ]);
        default = "horizontal";
        example = "horizontal";
        description = "Form factor fo the panel.";
      };
      plugin = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = "org.kde.panel";
        example = "org.kde.panel";
        description = "Type of plugin used for the panel.";
      };
      screen = lib.mkOption {
        type = lib.types.nullOr lib.types.int;
        default = null;
        example = "0";
        description = "Index of the screen it should be on.";
      };
      size = lib.types.submodule {
        options = {
          height = lib.mkOption {
            type = lib.types.nullOr lib.types.int;
            default = 32;
            description = "The height of the panel.";
          };
          offset = lib.mkOption {
            type = lib.types.nullOr lib.types.int;
            default = null;
            example = 100;
            description = "The offset of the panel from the anchor-point.";
          };
          minLength = lib.mkOption {
            type = lib.types.nullOr lib.types.int;
            default = null;
            example = 1000;
            description = "The minimum required length/width of the panel.";
          };
          maxLength = lib.mkOption {
            type = lib.types.nullOr lib.types.int;
            default = null;
            example = 1600;
            description = "The maximum allowed length/width of the panel.";
          };
        };
      };
      dialog = lib.types.submodule {
        options = {
          height = lib.types.nullOr lib.mkOption {
            type = lib.types.int;
            default = 400;
            description = "The height of the dialog box.";
          };
          width = lib.mkOption {
            type = lib.types.nullOr lib.types.int;
            default = null;
            example = 600;
            description = "The width of the dialog box.";
          };
        };
      };
      popup = lib.types.submodule {
        options = {
          height = lib.types.nullOr lib.mkOption {
            type = lib.types.int;
            default = 400;
            description = "The height of the dialog box.";
          };
          width = lib.mkOption {
            type = lib.types.nullOr lib.types.int;
            default = null;
            example = 600;
            description = "The width of the dialog box.";
          };
        };
      };
      location = lib.mkOption {
        type = lib.types.str;
        default = lib.types.nullOr (lib.types.enum [ "top" "bottom" "left" "right" "floating" ]);
        example = "left";
        description = "The location of the panel.";
      };
      alignment = lib.mkOption {
        type = lib.types.nullOr (lib.types.enum [ "left" "center" "right" ]);
        default = "center";
        example = "right";
        description = "The alignment of the panel.";
      };
      hiding = lib.mkOption {
        type = lib.types.nullOr (lib.types.enum [
          "none"
          "autohide"
          # Plasma 5 only
          "windowscover"
          "windowsbelow"
          # Plasma 6 only
          "dodgewindows"
          "normalpanel"
          "windowsgobelow"
        ]);
        default = "none";
        example = "autohide";
        description = ''
          The hiding mode of the panel. Here windowscover and windowsbelow are
          plasma 5 only, while dodgewindows, windowsgobelow and normalpanel are
          plasma 6 only.
        '';
      };
      floating = lib.mkEnableOption "Enable or disable floating style (plasma 6 only).";
      widgets = lib.mkOption {
        type = with lib.types;  nullOr listOf (either str widgetType);
        default = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.pager"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.marginsseperator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.showdesktop"
        ];
        example = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.marginsseperator"
          "org.kde.plasma.digitalclock"
        ];
        description = ''
          The widgets to use in the panel. To get the names, it may be useful
          to look in the share/plasma/plasmoids folder of the nix-package the
          widget/plasmoid is from. Some packages which include some
          widgets/plasmoids are for example plasma-desktop and
          plasma-workspace.
        '';
      };
      extraSettings = lib.mkOption {
        type = lib.types.attr;
        default = { };
        description = ''
          Extra lines to add to the layout.js. See
          https://develop.kde.org/docs/plasma/scripting/ for inspiration.
        '';
      };
    };
  };
  panelType = lib.types.submodule containmentType;
  
  screenType =  lib.types.submodule (containmentType // ({
    options = {
      formfactor = {
        default = "planar";
        example = "mediacenter";
      };
      plugin = {
        default = "org.kde.folder";
      };
      screen = {
        default = null;
      };
      widgets = {
        default = [ ];
      };
    };
  }));
  


  #
  # Functions to generate layout.js configurations from the widgetType
  #
  # Configgroups must be javascript lists.
  widgetConfigGroupFormat = group: ''[${lib.concatStringsSep ", " (map (s: "\"${s}\"") (lib.splitString "." group))}]'';
  # If the specified value is a string then add in extra quotes. If we have a
  # list, convert this to a javascript list.
  widgetConfigValueFormat = value: if (builtins.isString value) then "\"${value}\"" else ''[${(lib.concatStringsSep ", " (map (s: "\"${s}\"") value))}]'';
  # Generate writeConfig calls to include for a widget with additional
  # configurations.
  genWidgetConfigStr = widget: group: key: value:
    ''
      var w = panelWidgets["${widget}"]
      w.currentConfigGroup = ${widgetConfigGroupFormat group}
      w.writeConfig("${key}", ${widgetConfigValueFormat value})
    '';
  # Generate the text for all of the configuration for a widget with additional
  # configurations.



  # mergeAppletLists = return_obj: applet_list: lib.mkMerge [ return_obj { inherit applet_list; } ];
  

  
  
  # addApplet = return_obj@{ applet_list ? [], ...}: applet_config: let
  #     applet_obj = {

  #     };
  #     applet_obj_final = lib.mkMerge [ applet_obj screen_config.extraSettings ];
  #     return_obj_final = mergeAppletLists return_obj [ applet_obj_final ];
       
      
  #   in return_obj_final;
  # addPanel = return_obj@{ applet_list ? [], ...}: panel_config: let
  #     return_obj1 = addApplet return_obj panel_config;
  #     return_obj_final = mkIf (panel_config.widgets) addWidgetsToPanel return_obj1 panel_config.widgets;
  #   in return_obj_final;
  
  # addWidget = return_obj@{ applet_list ? [], screen_list ? [], ...}: widget_config: let
      
  #     return_obj1 = addApplet return_obj widget_config;
  #     return_obj_final = if (widget_config.widgets) 
  #       then addWidgetsToWidget return_obj1 containment_number widget_config.widgets 
  #       else return_obj1;
    
  #   in return_obj_final;
  # addWidgets = return_obj@{ applet_list ? [], ...}: to_process: let
  #     current_item = head to_process;
  #     other_items = drop 1 to_process;
  #     return_obj1 = addWidget return_obj current_item;
  #     return_obj_final = addWidgets return_obj1 other_items;
  #   in
  #   if to_process == [] then return_obj
  #   else return_obj_final;
  # # makeWidgetPositionsForScreen = 
  # addWidgetsToScreen = return_obj@{ applet_list ? [], ...}: containment: to_process: let
  #     return_obj1 = addWidgets return_obj to_process;
  #     return_obj_final = mergeAppletLists return_obj1 [ applet_obj_final ]; 
  #   in return_obj_final;
  # addScreen = return_obj@{ applet_list ? [], screen_list ? [], ...}: screen_config: let
  #     return_obj1 = addApplet return_obj screen_config;
  #     containment_number = return_obj1.applet_id-1;
  #     return_obj_final =  if (screen_config.widgets) 
  #       then addWidgetsToScreen return_obj1 containment_number screen_config.widgets 
  #       else return_obj1;
  #   in return_obj_final;
  # addScreens = return_obj@{ applet_list ? [], screen_list ? [], ...}: to_process: let
  #     current_item = head to_process;
  #     other_items = drop 1 to_process;
  #     return_obj1 = addScreen return_obj current_item;
  #     return_obj_final = addScreens return_obj1 other_items;
  #   in
  #   if to_process == [] then return_obj
  #   else return_obj_final;
  applet_filename = "plasma-org.kde.plasma.desktop-appletsrc";
  plasmashell_filename = "plasmashellrc";
  
  
  getContainments = config: if (lib.hasAttrPath [ "${applet_filename}" "Containments" ] config) then config.${applet_filename}."Containments" else { };
  getContainment = config: containment_id: let
      containments = (getContainments config);
    in if (lib.hasAttrPath [ containment_id ] containments) then containments.${containment_id} else { };
  getWidgets = config: containment_id: let
      containment = (getContainment config containment_id);
    in if (lib.hasAttrPath [ "Applets" ] containment) then containment."Applets" else { };
  getWidget = config: containment_id: widget_id: let
      widgets = (getWidgets config containment_id);
    in if (lib.hasAttrPath [ widget_id ] widgets) then widgets.${widget_id} else { };
  # containment Ids go from 10 to 99
  containment_id_start = 10;
  nextContainmentId = config: containment_id_start + builtins.length builtins.attrNames getContainments config;
  currentContainmentId = config: containment_id: (nextContainmentId config) - 1;
  nextWidgetId = config: containment_id: builtins.length builtins.attrNames getWidgets config containment_id;
  currentWidgetId = config: containment_id: (nextWidgetId config containment_id) - 1;
  getContainmentFromWidgetId = widget_id: substring 0 2 (toString widget_id);

  addWidgetsToPanel = return_obj@{ configFiles ? { }, ...}: containment_id: to_process: let
      return_obj1 = addWidgets return_obj containment_id to_process;

      widget_order = let
        widget_names = map (x: x.plugin) to_process;
      in {
        "General"."AppletOrder" = builtins.concatStringsSep ";" widget_names;
      };
      # Rename position attrs
     
      return_obj_final = lib.mkMerge [ return_obj1 
        { 
          configFiles."${applet_filename}".Containments."${containment_id}" = widget_order; 
        }
      ]; 
    in return_obj_final;
  addPanel = return_obj@{ configFiles ? { }, ...}: panel: let
      return_obj1 = addContainment return_obj panel;
      containment_id = (currentContainmentId configFiles);

      # Do plasmashellrc parts for Panels
      filtered_size = lib.attrsets.filterAttrs (n: v: builtins.elem n 
        [ "offset" "thickness" "minLength" "maxLength" ]) panel.size;
      plasmashellrc_obj = {
        panelVisibility = panel.hiding;
        alignment = panel.alignment;
        floating = panel.floating;
      # Add the dfault "per screen" settings
      } // {
        Defaults = {
          offset = panel.size.offset;
          thickness = panel.size.height;
          minLength = panel.size.minLength;
          maxLength = panel.size.maxLength;
        };
        
      # Add the per screen size arguments
      } // libs.mapAttrs' (name: value: nameValuePair 
        (name)
        ({
          offset = value.offset;
          thickness = value.height;
          minLength = value.minLength;
          maxLength = value.maxLength;
        }) 
      ) filtered_size;
      plasmashellrc_obj_final = plasmashellrc_obj;
      return_obj2 = lib.mkMerge [ return_obj1 
        { 
          configFiles."${plasmashell_filename}".PlasmaViews."Panel ${containment_id}" = plasmashellrc_obj_final;
        }
      ]; 

      return_obj_final =  if (panel.widgets) 
        then addWidgetsToPanel return_obj2 containment_id panel.widgets 
        else return_obj2;
    in return_obj_final;
  addPanels = return_obj@{ configFiles ? { },  ...}: to_process: let
      current_item = head to_process;
      other_items = drop 1 to_process;
      return_obj1 = addPanel return_obj current_item;
      return_obj_final = addPanels return_obj1 other_items;
    in
    if to_process == [] then return_obj
    else return_obj_final;
    # return_obj_final = mergeAppletLists return_obj [ applet_obj_final ];
  addContainment = return_obj@{ configFiles ? { }, ...}: containment: let
      containment_id = (currentContainmentId configFiles);
      containment_obj = {
        inherit (containment) plugin activityId formfactor;
        lastScreen = containment.screen;
        popupHeight = containment.popup.height;
        popupWidth = containment.popup.width;
        ConfigDialog.DialogpHeight = containment.dialog.height;
        ConfigDialog.DialogWidth = containment.dialog.width;
      };
      containment_obj_final = lib.mkMerge [ containment_obj containment.extraSettings
      ];
      
      return_obj_final = lib.mkMerge [ return_obj 
        { 
          configFiles."${applet_filename}".Containments."${containment_id}" = containment_obj_final; 
        }
      ]; 
    in return_obj_final;
      # return_obj_final = mergeAppletLists return_obj [ applet_obj_final ];
  addApplet = return_obj@{ configFiles ? { }, ...}: containment_id: applet: let
      applet_obj = {

      };
      applet_obj_final = lib.mkMerge [ applet_obj applet.extraSettings ];
      return_obj_final = lib.mkMerge [ return_obj {}
        # { 
        #   configFiles."${applet_filename}".Containments."${containment}" = updated_positions; 
        # }
      ]; 
    in return_obj_final;
  # TODO: This whole mapping bit could be done better somehow.
  # Dont know how tho
  nestedContainmentMapping = return_obj@{ configFiles ? { }, ...}: parent_id: let
      parent_containment_id = getContainmentFromWidgetId widget_id;
      parent_widget = getWidget configFiles parent_containment_id parent_widget;
      widget_path = [ "${applet_filename}" "Containments" "${parent_containment_id}" "Applets" "${parent_id}" ];
      mappings = {
        "org.kde.plasma.systemtray" = {
          inner_containment_config = {
            inherit (parent_widget) screen formfactor activityId location;
            plugin = "org.kde.plasma.private.systemtray";
          };
          inner_post_widgets = widgets: let
            widget_names = map (x: x.plugin) widgets;
          in {
            "General" = {
              "knownItems" = builtins.concatStringsSep "," widget_names;
            };
          };
          parent_modify = new_containment_id: [ 
            {
              path = widget_path ++ [ "Configuration" "SystrayContainmentId" ];
              update = old: new_containment_id;
            }
          ];
        };
      };

    
    in mappings;
  addWidgetsToWidget = return_obj@{ configFiles ? { }, ...}: widget_id: widgets: let
      # Add this new containment to its spot in the parent widget
      # Each nested plugin seems to store its nested containers ID
      # in its own special attribute so it needs to be mapped
      mapping = (nestedContainmentMapping return_obj widget_id).${parent_widget.plugin};
      # Make nested containment
      return_obj1 = addContainment return_obj mapping.inner_containment_config;
      containment_id = (currentContainmentId configFiles);
      # Update parents values based off contained containment
      return_obj2 = lib.updateManyAttrsByPath (mapping.parent_modify containment_id) return_obj1;
      # Add widgets to the inner containment
      return_obj3 = addWidgets return_obj2 containment_id widgets;
      # Do inner containments special thing if it has widgets (usually for ordering)
      updated_values = mapping.inner_post_widgets widgets;
      return_obj_final = lib.mkMerge [ return_obj3 
        { 
          configFiles."${applet_filename}".Containments."${containment_id}" = updated_values; 
        }
      ]; 
    in return_obj_final;
  addWidget = return_obj@{ configFiles ? { }, ...}: containment_id: widget: let
  
    return_obj1 = addApplet return_obj containment_id widget;
    widget_id = currentWidgetId config containment_id;
    return_obj_final = if (widget.widgets) 
      then addWidgetsToWidget return_obj1 widget_id widget.widgets 
      else return_obj1;
  
  in return_obj_final;
  addWidgets = return_obj@{ configFiles ? { }, ...}: containment_id: to_process: let
      current_item = head to_process;
      other_items = drop 1 to_process;
      return_obj1 = addWidget return_obj containment_id current_item;
      return_obj_final = addWidgets return_obj1 containment_id other_items;
    in
    if to_process == [] then return_obj
    else return_obj_final;

  mkWidgetPositions = return_obj@{ index ? 0, ... }: containment_id: to_process: let
      current_item = head to_process;
      other_items = drop 1 to_process;
      attr_name = "${containment_id}${index}";
      widget = current_item;
      
      return_obj1 = lib.attrsets.mapAttrs (name: value: 
        return_obj.name ++ "Applet-${attr_name}:${value.x},${value.y},${value.height},${value.length},${value.angle};"
      ) widget.position;
      return_obj_final = mkWidgetPositions return_obj1 containment_id other_items;
    in
    if to_process == [] then return_obj
    else return_obj_final;
  addWidgetsToScreen = return_obj@{ configFiles ? { }, ...}: containment_id: to_process: let
      return_obj1 = addWidgets return_obj containment_id to_process;

      positions = mkWidgetPositions { } containment_id to_process;
      # Rename position attrs
      updated_positions = lib.attrsets.mapAttrs' (name: value: lib.attrsets.nameValuePair 
        ("ItemGeometries" ++ (
          if (name == "horizontal") then "Horizontal"
          else if (name == "vertical") then "Vertical"
          else "-" ++ name
        ) (value)
      ) positions);
      return_obj_final = lib.mkMerge [ return_obj1 
        { 
          configFiles."${applet_filename}".Containments."${containment_id}" = updated_positions; 
        }
      ]; 
    in return_obj_final;
  addScreen = return_obj@{ configFiles ? { }, ...}: screen_config: let
      return_obj1 = addContainment return_obj screen_config;
      containment_id = (currentContainmentId configFiles);
      return_obj_final =  if (screen_config.widgets) 
        then addWidgetsToScreen return_obj1 containment_id screen_config.widgets 
        else return_obj1;
    in return_obj_final;
  addScreens = return_obj@{ configFiles ? { },  ...}: to_process: let
      current_item = head to_process;
      other_items = drop 1 to_process;
      return_obj1 = addScreen return_obj current_item;
      return_obj_final = addScreens return_obj1 other_items;
    in
    if to_process == [] then return_obj
    else return_obj_final;
in {
  options.programs.plasma.panels = lib.mkOption {
    type = lib.types.listOf panelType;
    default = [ ];
  };
  options.programs.plasma.screens = lib.mkOption {
    type = lib.types.listOf screenType;
    default = [ ];
  };
  config = let 
    screen_panels = addScreens { } programs.plasma.screens;
    all_panels = addPanels screen_panels programs.plasma.panels;
  in mkIf (cfg.enable && (lib.length cfg.panels) + (lib.length cfg.screens) > 0) 
  {
    programs.plasma.configFile = lib.mkMerge [ all_panels.configFile cfg.configFile ];
  #   programs.plasma.startup.dataFile."layout.js" = ''
  #     // Removes all existing panels
  #     var allPanels = panels();
  #     for (var panelIndex = 0; panelIndex < allPanels.length; panelIndex++) {
  #       var p = allPanels[panelIndex];
  #       p.remove();
  #     }

  #     // Adds the panels
  #     ${panelsToLayoutJS config.programs.plasma.panels}
  #   '';

  #   # Very similar to applying themes, we keep track of the last time the panel
  #   # was generated successfully, and run this only once per generation (granted
  #   # everything succeeds and we are not using overrideConfig).
  #   programs.plasma.startup.autoStartScript."apply_layout" = {
  #     text = ''
  #       layout_file="${config.xdg.dataHome}/plasma-manager/${cfg.startup.dataDir}/layout.js"
  #       last_update="$(sha256sum $layout_file)"
  #       last_update_file=${config.xdg.dataHome}/plasma-manager/last_run_layouts
  #       if [ -f "$last_update_file" ]; then
  #         stored_last_update=$(cat "$last_update_file")
  #       fi

  #       if ! [ "$last_update" = "$stored_last_update" ]; then
  #         # We delete plasma-org.kde.plasma.desktop-appletsrc to hinder it
  #         # growing indefinitely. See:
  #         # https://github.com/pjones/plasma-manager/issues/76
  #         [ -f ${config.xdg.configHome}/plasma-org.kde.plasma.desktop-appletsrc ] && rm ${config.xdg.configHome}/plasma-org.kde.plasma.desktop-appletsrc

  #         # And finally apply the layout.js
  #         success=1
  #         qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "$(cat $layout_file)" || success=0
  #         [ $success -eq 1 ] && echo "$last_update" > "$last_update_file"
  #       fi
  #     '';
  #     # Setting up the panels should happen after setting the theme as the theme
  #     # may overwrite some settings (like the kickoff-icon)
  #     priority = 2;
  #   };
  };
}

