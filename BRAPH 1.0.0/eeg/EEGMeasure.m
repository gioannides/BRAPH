classdef EEGMeasure < HashListElement
    % EEGMeasure < HashListElement (Abstract) : EEG measures
    %   EEGMeasure represents a measure of EEG data.
    %   Instances of this class cannot be created. Use one of the subclasses 
    %   (e.g., EEGMeasureBUD).
    %
    % EEGMeasure properties (Access = protected):
    %   props               -   cell array of object properties < ListElement
    %
    % EEGMeasure properties (Constants):
    %   CODE                -   code numeric code  
    %   CODE_TAG            -   code tag  
    %   CODE_FORMAT         -   code format 
    %   CODE_DEFAULT        -   code default 
    %
    %   PARAM               -   parameters numeric code 
    %   PARAM_TAG           -   parameters tag 
    %   PARAM_FORMAT        -   parameters format 
    %   PARAM_DEFAULT       -   parameters default 
    %
    %   NOTES               -   notes numeric code 
    %   NOTES_TAG           -   notes tag 
    %   NOTES_FORMAT        -   notes format 
    %   NOTES_DEFAULT       -   notes default 
    %
    %   GROUP1              -   group numeric code 
    %   GROUP1_TAG          -   group tag 
    %   GROUP1_FORMAT       -   group format 
    %   GROUP1_DEFAULT      -   group default 
    %
    %   VALUES1             -   values numeric code 
    %   VALUES1_TAG         -   values tag 
    %   VALUES1_FORMAT      -   values format 
    %   VALUES1_DEFAULT     -   values default 
    %
    % EEGMeasure methods (Access = protected):
    %   EEGMeasure         -   constructor
    %
    % EEGMeasure methods:
    %   setProp         -   sets property value < ListElement
    %   getProp         -   gets property value, format and tag < ListElement
    %   getPropValue    -   string of property value < ListElement
    %   getPropFormat	-   string of property format < ListElement
    %   getPropTag      -   string of property tag < ListElement
    %   mean            -   mean of measure
    %   std             -   standard deviation of measure
    %   var             -   variance of measure
    %
    % EEGMeasure methods (Abstract):
    %   hash            -   hash value of the hash list element < HashListElement
    %   isMeasure       -   return true if measure
    %   isComparison    -   return true if comparison
    %   isRandom        -   return true if comparison with random graphs
    %
    % EEGMeasure methods (Static):
    %   cleanXML        -   removes whitespace nodes from xmlread < ListElement
    %   propnumber      -   number of properties
    %   getTags         -   cell array of strings with the tags of the properties
    %   getFormats      -   cell array with the formats of the properties
    %   getDefaults     -   cell array with the defaults of the properties
    %   getOptions      -   cell array with options (only for properties with options format)
    %
    % See also HashListElement, EEGMeasureBUD, EEGMeasureBUT, EEGMeasureWU.
    
    % Author: Mite Mijalkov, Ehsan Kakaei & Giovanni Volpe
    % Date: 2016/01/01
    
    properties (Constant)

        % measure code
        CODE = 1
        CODE_TAG = 'code'
        CODE_FORMAT = BNC.NUMERIC
        CODE_DEFAULT = 1
        
        % parameters
        PARAM = 2
        PARAM_TAG = 'parameters'
        PARAM_FORMAT = BNC.NUMERIC
        PARAM_DEFAULT = NaN

        % notes
        NOTES = 3
        NOTES_TAG = 'notes'
        NOTES_FORMAT = BNC.CHAR
        NOTES_DEFAULT = '---'

        % group 1
        GROUP1 = 4
        GROUP1_TAG = 'group1'
        GROUP1_FORMAT = BNC.NUMERIC
        GROUP1_DEFAULT = 1

        % measure values group 1
        % global measures: column vector [subjects x 1]
        % nodal measures: matrix [subjects x regions]
        VALUES1 = 5
        VALUES1_TAG = 'values1'
        VALUES1_FORMAT = BNC.NUMERIC
        VALUES1_DEFAULT = NaN
        
    end
    methods (Access = protected)
        function m = EEGMeasure(varargin)
            % EEGMEASURE() creates EEG measures with default properties.
            %   This method is only accessible by the subclasses of EEGMeasure.
            %
            % EEGMEASURE(Tag1,Value1,Tag2,Value2,...) initializes property Tag1 to Value1, 
            %   Tag2 to Value2, ... .
            %
            % See also EEGMeasure.
            
            m = m@HashListElement(varargin{:});
        end
    end
    methods
        function r = mean(m)
            % MEAN mean of measure
            %
            % R = MEAN(M) returns the mean R of the measure M.
            %
            % See also EEGMeasure.
            
            r = mean(m.getProp(EEGMeasure.VALUES1),1);
        end
        function r = std(m)
            % STD standard deviation of measure
            %
            % R = STD(M) returns the standard deviation R of the measure M.
            %
            % See also EEGMeasure.
            
            r = std(m.getProp(EEGMeasure.VALUES1),1);
        end
        function r = var(m)
            % VAR variance of measure
            %
            % R = VAR(M) returns the variance R of the measure M.
            %
            % See also EEGMeasure.
            
            r = var(m.getProp(EEGMeasure.VALUES1),1);
        end
    end
    methods (Abstract)
        bool = isMeasure(m)  % return true if measure
        bool = isComparison(m)  % return true if comparison
        bool = isRandom(m)  % return true if comparison with random graphs
    end
    methods (Static)
        function N = propnumber()
            % PROPNUMBER number of properties
            %
            % N = PROPNUMBER() gets the total number of properties of EEGMeasure.
            %
            % See also EEGMeasure.

            N = 5;
        end
        function tags = getTags()
            % GETTAGS cell array of strings with the tags of the properties
            %
            % TAGS = GETTAGS() returns a cell array of strings with the tags 
            %   of all properties of EEGMeasure.
            %
            % See also EEGMeasure, ListElement.
            
            tags = {EEGMeasure.CODE_TAG ...
                EEGMeasure.PARAM_TAG ...
                EEGMeasure.NOTES_TAG ...
                EEGMeasure.GROUP1_TAG ...
                EEGMeasure.VALUES1_TAG};
        end
        function formats = getFormats()
            % GETFORMATS cell array with the formats of the properties
            %
            % FORMATS = GETFORMATS() returns a cell array with the formats
            %   of all properties of EEGMeasure.
            %
            % See also EEGMeasure, ListElement.
            
            formats = {EEGMeasure.CODE_FORMAT ...
                EEGMeasure.PARAM_FORMAT ...
                EEGMeasure.NOTES_FORMAT ...
                EEGMeasure.GROUP1_FORMAT ...
                EEGMeasure.VALUES1_FORMAT};
        end
        function defaults = getDefaults()
            % GETDEFAULTS cell array with the default values of the properties
            %
            % DEFAULTS = GETDEFAULTS() returns a cell array with the default values
            %   of all properties of EEGMeasure.
            %
            % See also EEGMeasure, ListElement.
            
            defaults = {EEGMeasure.CODE_DEFAULT ...
                EEGMeasure.PARAM_DEFAULT ...
                EEGMeasure.NOTES_DEFAULT ...
                EEGMeasure.GROUP1_DEFAULT ...
                EEGMeasure.VALUES1_DEFAULT};
        end
        function options = getOptions(~)  % (i)
            % GETOPTIONS cell array with options (only for properties with options format)
            %
            % OPTIONS = GETOPTIONS(PROP) returns a cell array containing the options
            %   of the properties specified by PROP of EEGMeasure.
            %   If the PROP is not "options", it returns an empty cell array. 
            %
            % See also EEGMeasure, ListElement.
            
            options = {};
        end
    end
end