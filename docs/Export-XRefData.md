---
external help file: StreamXRef-help.xml
Module Name: StreamXRef
online version: https://github.com/awsr/PS-StreamXRef/blob/master/docs/Export-XRefData.md
schema: 2.0.0
---

# Export-XRefData

## SYNOPSIS
Export the contents of the lookup data cache to a file.

## SYNTAX

```
Export-XRefData [-Path] <String> [-ExcludeApiKey] [-ExcludeClipMapping] [-Force] [-NoClobber] [-Compress]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The `Export-XRefData` cmdlet exports the contents of the lookup data cache as JSON to a specified file.

The files created by this cmdlet can be used with `Import-XRefData`.

## EXAMPLES

### Example 1
```
PS > Export-XRefData -Path XRefData.json
```

This will export the contents of the lookup data cache to a file.

### Example 2
```
PS > Register-EngineEvent -SourceIdentifier XRefNewDataAdded -Action {Export-XRefData -Path /full/path/to/datacache.json}
```

Automatically export the data cache whenever new data is added.

## PARAMETERS

### -Compress
Removes unnecessary whitespace from the JSON string. This results in smaller files at the expense of readability.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeApiKey
Excludes the cached API key from the export.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: NoKey, EAK

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeClipMapping
Excludes the cached Clip to Username results from the export.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: NoMapping, ECM

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Forces cmdlet to run and overwrite read-only files.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoClobber
Prevents overwriting an existing file.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Specifies the path to the file where the JSON formatted data will be stored.

```yaml
Type: String
Parameter Sets: (All)
Aliases: PSPath

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipeline a value for `Path` either as a string or by property name.

## OUTPUTS

### None

## NOTES

## RELATED LINKS
