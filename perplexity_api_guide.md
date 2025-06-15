# Perplexity API Guide for News Research System

## Overview

Perplexity's Sonar API provides real-time web search and Q&A capabilities powered by AI. This guide covers key features, filters, and best practices for building a news research system.

## Available Models

### 1. **Sonar** (sonar)
- **Context Window**: 127,000 tokens
- **Pricing**: $1.00 per million tokens
- **Speed**: 177 tokens/second
- **Latency**: 0.77 seconds
- **Best For**: Fast, cost-effective searches
- **F-Score**: 0.773

### 2. **Sonar Pro** (sonar-pro)
- **Context Window**: 200,000 tokens
- **Pricing**: Higher than Sonar (exact price varies)
- **Speed**: 107 tokens/second
- **Best For**: In-depth, multi-step queries with more citations
- **F-Score**: 0.858 (best for factuality)
- **Features**: Double the citations compared to Sonar

### 3. **Sonar Reasoning** (sonar-reasoning)
- **Pricing**: $2.00 per million tokens
- **Latency**: 1.32 seconds
- **Best For**: Complex reasoning tasks

### 4. **Sonar Deep Research** (sonar-deep-research)
- **Best For**: Comprehensive research requiring multiple searches

## Rate Limits

- **Default**: 50 requests per minute for all Sonar models
- **Pro Subscription**: Higher rate limits available
- **Note**: No feature gating based on spending tiers

## Filter Parameters

### 1. **Search Domain Filter**

Control which websites are included or excluded from search results.

```python
payload = {
    "model": "sonar-pro",
    "messages": [...],
    "search_domain_filter": [
        "nytimes.com",        # Include
        "reuters.com",        # Include
        "-pinterest.com",     # Exclude
        "-reddit.com"         # Exclude
    ]
}
```

**Best Practices:**
- Use simple domain format (example.com, not www.example.com)
- Limit to fewer, more targeted domains for better results
- Maximum 10 domains per request
- Filtering applies to all subdomains

### 2. **Date Range Filters**

Filter search results by specific date ranges.

```python
payload = {
    "model": "sonar",
    "messages": [...],
    "search_after_date_filter": "3/1/2025",
    "search_before_date_filter": "3/5/2025"
}
```

### 3. **Search Recency Filter**

Filter by relative time periods.

```python
payload = {
    "model": "sonar-pro",
    "messages": [...],
    "search_recency_filter": "week"  # Options: month, week, day, hour
}
```

### 4. **User Location Filter**

Refine results based on geographic location.

```python
payload = {
    "model": "sonar",
    "messages": [...],
    "web_search_options": {
        "user_location": {
            "latitude": 40.7128,
            "longitude": -74.0060,
            "country": "US"
        }
    }
}
```

### 5. **Search Context Size**

Control the amount of search context.

```python
payload = {
    "model": "sonar-pro",
    "messages": [...],
    "web_search_options": {
        "search_context_size": "high"  # Options: low, medium, high
    }
}
```

## Structured Outputs

Available for structured data extraction (only with "sonar" model currently).

### JSON Schema Format

```python
payload = {
    "model": "sonar",
    "messages": [...],
    "response_format": {
        "type": "json_schema",
        "json_schema": {
            "name": "news_article",
            "schema": {
                "type": "object",
                "properties": {
                    "title": {"type": "string"},
                    "summary": {"type": "string"},
                    "date": {"type": "string"},
                    "source": {"type": "string"},
                    "key_points": {
                        "type": "array",
                        "items": {"type": "string"}
                    }
                },
                "required": ["title", "summary", "date", "source"]
            }
        }
    }
}
```

### Regex Format

```python
payload = {
    "model": "sonar",
    "messages": [...],
    "response_format": {
        "type": "regex",
        "regex": r"\d{4}-\d{2}-\d{2}"  # Date pattern
    }
}
```

## Additional Features

### 1. **Citations**
- All responses include citations by default
- No additional charge for citation tokens
- Sonar Pro provides 2x more citations than Sonar

### 2. **Related Questions**
```python
payload = {
    "model": "sonar-pro",
    "messages": [...],
    "return_related_questions": True
}
```

## Best Practices for News Research

### 1. **Model Selection**
- **Breaking News**: Use Sonar with `search_recency_filter: "hour"`
- **In-Depth Analysis**: Use Sonar Pro for comprehensive coverage
- **Fact-Checking**: Sonar Pro (highest factuality score)
- **Quick Updates**: Sonar (fastest response time)

### 2. **Domain Filtering Strategy**
```python
# For quality news sources
news_domains = [
    "reuters.com",
    "apnews.com",
    "nytimes.com",
    "wsj.com",
    "bbc.com",
    "-socialmedia.com",  # Exclude social media
    "-blog.com"          # Exclude personal blogs
]
```

### 3. **Time-Based Research**
```python
# For daily news digest
payload = {
    "model": "sonar",
    "messages": [{"role": "user", "content": "Latest tech news"}],
    "search_recency_filter": "day",
    "search_domain_filter": ["techcrunch.com", "theverge.com", "arstechnica.com"]
}

# For historical context
payload = {
    "model": "sonar-pro",
    "messages": [{"role": "user", "content": "Evolution of AI regulation"}],
    "search_after_date_filter": "1/1/2024",
    "search_before_date_filter": "12/31/2024"
}
```

### 4. **Geographic Focus**
```python
# For local news
payload = {
    "model": "sonar",
    "messages": [{"role": "user", "content": "Local business news"}],
    "web_search_options": {
        "user_location": {
            "latitude": 37.7749,
            "longitude": -122.4194,
            "country": "US"
        }
    },
    "search_recency_filter": "week"
}
```

## Example Implementation

```python
import requests
import json

class PerplexityNewsResearcher:
    def __init__(self, api_key):
        self.api_key = api_key
        self.base_url = "https://api.perplexity.ai"
        self.headers = {
            "Authorization": f"Bearer {api_key}",
            "Content-Type": "application/json"
        }
    
    def search_recent_news(self, topic, time_filter="day", domains=None):
        payload = {
            "model": "sonar",
            "messages": [
                {"role": "user", "content": f"Latest news about {topic}"}
            ],
            "search_recency_filter": time_filter,
            "return_related_questions": True
        }
        
        if domains:
            payload["search_domain_filter"] = domains
        
        response = requests.post(
            f"{self.base_url}/chat/completions",
            headers=self.headers,
            json=payload
        )
        
        return response.json()
    
    def deep_research(self, topic, date_range=None, location=None):
        payload = {
            "model": "sonar-pro",
            "messages": [
                {"role": "user", "content": f"Comprehensive analysis of {topic}"}
            ],
            "web_search_options": {
                "search_context_size": "high"
            }
        }
        
        if date_range:
            payload["search_after_date_filter"] = date_range["start"]
            payload["search_before_date_filter"] = date_range["end"]
        
        if location:
            payload["web_search_options"]["user_location"] = location
        
        response = requests.post(
            f"{self.base_url}/chat/completions",
            headers=self.headers,
            json=payload
        )
        
        return response.json()
```

## Important Notes

1. **Data Privacy**: Your data is not used for training and is hosted in the US
2. **Initialization Delay**: First request with new structured output schema may take 10-30 seconds
3. **Domain Filter Impact**: Adding filters may slightly increase response time
4. **Citation Tokens**: No longer charged separately, making pricing simpler
5. **Feature Access**: All features available to all users regardless of spending tier